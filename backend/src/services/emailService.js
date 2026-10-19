const nodemailer = require("nodemailer");
const config = require("../config/env");

const transporter = nodemailer.createTransport({
  host: config.smtp.host,
  port: config.smtp.port,
  secure: config.smtp.port === 465,
  auth: {
    user: config.smtp.user,
    pass: config.smtp.password,
  },
});

async function verifyEmailTransport() {
  if (!config.smtp.user || !config.smtp.password) {
    throw new Error("SMTP credentials are not configured");
  }

  await transporter.verify();
}

async function sendLoginCode(email, code) {
  if (!config.smtp.user || !config.smtp.password) {
    throw new Error("SMTP credentials are not configured");
  }

  await transporter.sendMail({
    from: `"ICMTA Secretariat" <${config.smtp.user}>`,
    to: email,
    subject: "Your ICMTA sign-in verification code",
    text: `Your ICMTA verification code is ${code}. This code expires in ${config.auth.otpExpiresMinutes} minutes. If you did not request this code, you can safely ignore this email.`,
    html: `
      <div style="font-family:Arial,sans-serif;max-width:600px;margin:auto;">
        <h2>ICMTA Sign-In</h2>

        <p>Use the verification code below to sign in:</p>

        <div style="
          font-size:32px;
          font-weight:bold;
          letter-spacing:8px;
          margin:24px 0;
        ">
          ${code}
        </div>

        <p>
          This code expires in
          <strong>${config.auth.otpExpiresMinutes} minutes</strong>.
        </p>

        <p>
          If you did not request this code, you can safely ignore this email.
        </p>

        <p>Regards,<br>ICMTA Secretariat</p>
      </div>
    `,
  });
}

module.exports = {
  verifyEmailTransport,
  sendLoginCode,
};