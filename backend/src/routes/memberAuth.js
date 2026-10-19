const { requireMember } = require("../middleware/memberAuth");

const express = require("express");
const crypto = require("crypto");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const { query } = require("../db/pool");
const config = require("../config/env");

const router = express.Router();

/*
 * Generate a numeric OTP.
 * Example: 482913
 */
function generateOtp() {
  const min = 10 ** (config.auth.otpLength - 1);
  const max = 10 ** config.auth.otpLength;

  return String(crypto.randomInt(min, max));
}

/*
 * Send OTP email.
 *
 * SMTP is intentionally NOT connected yet.
 * When the Hostinger email account is ready,
 * we will replace the contents of this function
 * with the real SMTP implementation.
 */
async function sendOtpEmail(email, otp) {
  if (!config.resend.apiKey) {
    throw new Error("RESEND_API_KEY is not configured");
  }

  const response = await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${config.resend.apiKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      from: "ICMTA <onboarding@resend.dev>",
      to: [email],
      subject: "ICMTA Verification Code",
      text:
        `Your ICMTA verification code is ${otp}.\n\n` +
        `This code expires in ${config.auth.otpExpiresMinutes} minutes.\n\n` +
        `If you did not request this code, you can ignore this email.`,
    }),
  });

  const result = await response.json();

  if (!response.ok) {
    console.error("[RESEND] Email API error:", result);

    throw new Error(
      result?.message || "Failed to send verification email"
    );
  }

  console.log(
    `[RESEND] Verification email sent. ID: ${result.id}`
  );

  return result;
}


/*
 * =========================================================
 * REQUEST OTP
 * POST /api/member/request-code
 * =========================================================
 */
async function requestOtp(req, res, next, purpose) {
  try {
    const email = String(req.body?.email || "")
      .trim()
      .toLowerCase();

    if (!email) {
      return res.status(400).json({
        success: false,
        error: "Email is required",
      });
    }

    /*
     * Basic email format validation.
     */
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email)) {
      return res.status(400).json({
        success: false,
        error: "Enter a valid email address",
      });
    }

    /*
     * Rate limit:
     * Maximum number of OTP requests per hour.
     */
    const requestRows = await query(
      `
      SELECT COUNT(*) AS request_count
      FROM auth_otp_codes o
      INNER JOIN auth_users u
        ON u.auth_user_id = o.auth_user_id
      WHERE u.email = ?
        AND o.created_at >= DATE_SUB(NOW(), INTERVAL 1 HOUR)
      `,
      [email]
    );

    const requestCount = Number(requestRows[0]?.request_count || 0);

    if (requestCount >= config.auth.maxCodeRequestsPerHour) {
      return res.status(429).json({
        success: false,
        error: "Too many code requests. Please try again later.",
      });
    }

    /*
     * Find existing authentication user.
     */
    let users = await query(
      `
      SELECT
        auth_user_id,
        email,
        email_verified,
        is_active
      FROM auth_users
      WHERE email = ?
      LIMIT 1
      `,
      [email]
    );

    let authUser;

    /*
     * Create authentication user if it does not exist.
     */
    if (users.length === 0) {
  if (purpose === "signin") {
    return res.status(404).json({
      success: false,
      error: "No account found. Please register first.",
    });
  }

  const result = await query(
    `INSERT INTO auth_users
      (email, email_verified, is_active)
     VALUES (?, FALSE, TRUE)`,
    [email]
  );

  authUser = {
    auth_user_id: result.insertId,
    email,
    email_verified: false,
    is_active: true,
  };
} else {
  authUser = users[0];

  if (purpose === "registration" && authUser.email_verified) {
    return res.status(409).json({
      success: false,
      error: "An account already exists. Please sign in.",
    });
  }
}

    /*
     * Do not allow inactive authentication accounts.
     */
    if (!authUser.is_active) {
      return res.status(403).json({
        success: false,
        error: "This account is inactive.",
      });
    }

    /*
     * Generate OTP.
     */
    const otp = generateOtp();

    /*
     * Hash OTP before storing it.
     * The plain OTP is never stored in the database.
     */
    const codeHash = await bcrypt.hash(otp, 10);

    /*
     * OTP expiry.
     */
    const expiresAt = new Date(
      Date.now() + config.auth.otpExpiresMinutes * 60 * 1000
    );

    /*
     * Invalidate previous unused OTPs for this user.
     */
    await query(
      `
      UPDATE auth_otp_codes
      SET used_at = NOW()
      WHERE auth_user_id = ?
        AND used_at IS NULL
      `,
      [authUser.auth_user_id]
    );

    /*
     * Store new OTP.
     */
    await query(
  `INSERT INTO auth_otp_codes
    (auth_user_id, code_hash, expires_at, attempts, purpose)
   VALUES (?, ?, ?, 0, ?)`,
  [authUser.auth_user_id, codeHash, expiresAt, purpose]
);

    /*
     * Send OTP.
     *
     * Currently this only logs the OTP in development.
     * Later this function will use Hostinger SMTP.
     */
    await sendOtpEmail(email, otp);

    return res.json({
      success: true,
      message: "Verification code sent",
      expires_in_minutes: config.auth.otpExpiresMinutes,
    });

  } catch (err) {
    next(err);
  }
}
// SECTION D: Register both OTP request routes
router.post("/member/request-code", (req, res, next) =>
  requestOtp(req, res, next, "signin")
);

router.post("/member/register/request-code", (req, res, next) =>
  requestOtp(req, res, next, "registration")
);



/*
 * =========================================================
 * VERIFY OTP
 * POST /api/member/verify
 * =========================================================
 */
router.post("/member/verify", async (req, res, next) => {
  try {
    const email = String(req.body?.email || "")
      .trim()
      .toLowerCase();

    const code = String(req.body?.code || "").trim();

    if (!email || !code) {
      return res.status(400).json({
        success: false,
        error: "Email and verification code are required",
      });
    }

    /*
     * OTP must contain exactly the configured number
     * of numeric digits.
     */
    const codeRegex = new RegExp(
      `^\\d{${config.auth.otpLength}}$`
    );

    if (!codeRegex.test(code)) {
      return res.status(400).json({
        success: false,
        error: "Invalid verification code",
      });
    }

    /*
     * Find authentication user.
     */
    const users = await query(
      `
      SELECT
        auth_user_id,
        email,
        email_verified,
        is_active
      FROM auth_users
      WHERE email = ?
      LIMIT 1
      `,
      [email]
    );

    const authUser = users[0];

    if (!authUser || !authUser.is_active) {
      return res.status(401).json({
        success: false,
        error: "Invalid verification request",
      });
    }

    /*
     * Get the latest unused OTP.
     */
    const purpose = String(req.body?.purpose || "signin").trim();

if (!["registration", "signin"].includes(purpose)) {
  return res.status(400).json({
    success: false,
    error: "Invalid verification purpose",
  });
}

const otpRows = await query(
  `
  SELECT
    otp_id,
    code_hash,
    expires_at,
    attempts,
    used_at
  FROM auth_otp_codes
  WHERE auth_user_id = ?
    AND purpose = ?
    AND used_at IS NULL
  ORDER BY otp_id DESC
  LIMIT 1
  `,
  [authUser.auth_user_id, purpose]
);
    const otpRecord = otpRows[0];

    if (!otpRecord) {
      return res.status(401).json({
        success: false,
        error: "No active verification code. Please request a new code.",
      });
    }

    /*
     * Check expiry.
     */
    if (new Date(otpRecord.expires_at).getTime() < Date.now()) {
      await query(
        `
        UPDATE auth_otp_codes
        SET used_at = NOW()
        WHERE otp_id = ?
        `,
        [otpRecord.otp_id]
      );

      return res.status(401).json({
        success: false,
        error: "Verification code has expired. Please request a new code.",
      });
    }

    /*
     * Check maximum attempts.
     */
    if (Number(otpRecord.attempts) >= config.auth.maxOtpAttempts) {
      await query(
        `
        UPDATE auth_otp_codes
        SET used_at = NOW()
        WHERE otp_id = ?
        `,
        [otpRecord.otp_id]
      );

      return res.status(401).json({
        success: false,
        error: "Too many incorrect attempts. Please request a new code.",
      });
    }

    /*
     * Compare entered OTP with stored hash.
     */
    const validCode = await bcrypt.compare(
      code,
      otpRecord.code_hash
    );

    /*
     * Incorrect OTP.
     */
    if (!validCode) {
      await query(
        `
        UPDATE auth_otp_codes
        SET attempts = attempts + 1
        WHERE otp_id = ?
        `,
        [otpRecord.otp_id]
      );

      const attemptsUsed = Number(otpRecord.attempts) + 1;
      const attemptsRemaining =
        config.auth.maxOtpAttempts - attemptsUsed;

      return res.status(401).json({
        success: false,
        error: "Invalid verification code",
        attempts_remaining: Math.max(attemptsRemaining, 0),
      });
    }
// Check sign-in eligibility BEFORE consuming the OTP
    if (purpose === "signin" && !authUser.email_verified) {
  return res.status(403).json({
    success: false,
    error: "Please complete registration first.",
  });
}

    /*
     * OTP is correct.
     * Mark it as used.
     */
    await query(
      `
      UPDATE auth_otp_codes
      SET used_at = NOW()
      WHERE otp_id = ?
      `,
      [otpRecord.otp_id]
    );


    // Check sign-in eligibility BEFORE consuming the OTP

    /*
     * Mark email as verified.
     */
    if (purpose === "registration") {
  await query(
    `
    UPDATE auth_users
    SET email_verified = TRUE
    WHERE auth_user_id = ?
    `,
    [authUser.auth_user_id]
  );
}

    /*
     * JWT secret must exist.
     */
    if (!config.jwt.secret) {
      return res.status(500).json({
        success: false,
        error: "JWT_SECRET is not configured",
      });
    }

    /*
     * Create member authentication JWT.
     *
     * At this stage the authentication system is
     * independent of the members table.
     */
    const token = jwt.sign(
      {
        sub: String(authUser.auth_user_id),
        auth_user_id: authUser.auth_user_id,
        email: authUser.email,
        role: "member",
      },
      config.jwt.secret,
      {
        expiresIn: config.jwt.expiresIn,
        algorithm: "HS256",
      }
    );

    return res.json({
      success: true,
      message: "Verification successful",
      token,
      member_id: null,
      is_admin: false,
      expires_in_minutes: Number(
        process.env.JWT_EXPIRE_MINUTES || 60
      ),
    });

  } catch (err) {
    next(err);
  }
});


router.get("/member/me", requireMember, async (req, res) => {
  res.json({
    success: true,
    message: "Member authentication is working",
    data: {
      auth_user_id: req.memberAuth.auth_user_id,
      email: req.memberAuth.email,
      role: req.memberAuth.role,
    },
  });
});
module.exports = router;
