
const jwt = require("jsonwebtoken");
const config = require("../config/env");
const { query } = require("../db/pool");

/**
 * Authenticate a registered account and retrieve its current
 * membership status from MySQL.
 *
 * IMPORTANT:
 * - Registration and OTP verification do not grant membership.
 * - Membership is checked against the database on every request.
 * - This prevents an outdated JWT from granting access after membership expires.
 */
async function requireAuth(req, res, next) {
  try {
    // Read the Bearer token sent by the frontend in the Authorization header.
    const authHeader = req.headers.authorization || "";

    if (!authHeader.startsWith("Bearer ")) {
      return res.status(401).json({
        success: false,
        detail: "Authentication required",
      });
    }

    const token = authHeader.slice(7).trim();

    if (!token) {
      return res.status(401).json({
        success: false,
        detail: "Authentication required",
      });
    }

    // Ensure the server has a JWT secret before validating the token.
    if (!config.jwt.secret) {
      return res.status(500).json({
        success: false,
        detail: "JWT_SECRET is not configured",
      });
    }

    // Verify the token's signature and expiry.
    // HS256 matches the signing algorithm used by the existing login flow.
    const decoded = jwt.verify(token, config.jwt.secret, {
      algorithms: ["HS256"],
    });

    
    // Handle admin JWTs separately from member authentication.
    if (decoded.role === "admin") {
      const adminId = Number(decoded.sub || decoded.admin_id);

      if (!Number.isInteger(adminId) || adminId <= 0) {
        return res.status(401).json({
          success: false,
          detail: "Invalid admin authentication token",
        });
      }

      const admins = await query(
        `SELECT admin_id, user_id, is_active
         FROM admin_users
         WHERE admin_id = ?
         LIMIT 1`,
        [adminId]
      );

      const admin = admins[0];

      if (!admin || Number(admin.is_active) !== 1) {
        return res.status(403).json({
          success: false,
          detail: "Admin account is inactive or unavailable",
        });
      }

      req.memberAuth = {
        auth_user_id: null,
        email: null,
        member_id: null,
        is_member: false,
        is_admin: true,
        admin_id: admin.admin_id,
        account_type: "admin",
      };

      return next();
    }


    // Support both token formats used by the existing authentication flow.
    const authUserId = decoded.auth_user_id || decoded.sub;

    if (!authUserId) {
      return res.status(401).json({
        success: false,
        detail: "Invalid authentication token",
      });
    }

    // Fetch the current account and its linked membership.
    // LEFT JOIN allows registered users without a member_id to log in.
    const rows = await query(
      `
      SELECT
        u.auth_user_id,
        u.email,
        u.is_active AS account_is_active,
        u.member_id,
        m.is_active AS member_is_active,
        m.my_status AS member_status
      FROM auth_users u
      LEFT JOIN members m
        ON m.member_id = u.member_id
      WHERE u.auth_user_id = ?
      LIMIT 1
      `,
      [authUserId]
    );

    const user = rows[0];

    // Reject accounts that do not exist or have been deactivated.
    if (!user || Number(user.account_is_active) !== 1) {
      return res.status(403).json({
        success: false,
        detail: "Account is inactive or unavailable",
      });
    }

    // Grant membership access only when the account is linked to a real
    // member record whose is_active flag is 1 and my_status is "Active".
    // Number() handles MySQL values returned as either numbers or strings.
    const isMember =
      user.member_id != null &&
      Number(user.member_is_active) === 1 &&
      String(user.member_status || "").trim().toLowerCase() === "active";

    // Make the verified account and membership information available
    // to the route handler through req.memberAuth.
    req.memberAuth = {
      auth_user_id: user.auth_user_id,
      email: user.email,
      member_id: user.member_id || null,
      is_member: isMember,
      account_type: isMember ? "member" : "registered",
    };

    // The user is authenticated. Route-specific middleware decides
    // whether registration alone or active membership is required.
    return next();
  } catch (err) {
    // Return clear authentication errors instead of exposing internal details.
    if (err.name === "TokenExpiredError") {
      return res.status(401).json({
        success: false,
        detail: "Authentication token expired",
      });
    }

    if (err.name === "JsonWebTokenError") {
      return res.status(401).json({
        success: false,
        detail: "Invalid authentication token",
      });
    }

    // Pass database and unexpected errors to the existing Express error handler.
    return next(err);
  }
}

/**
 * Restrict a route to active ICMTA members.
 * Registered users can authenticate, but cannot access these routes.
 */
function requireMember(req, res, next) {
  return requireAuth(req, res, () => {
    if (!req.memberAuth.is_member) {
      return res.status(403).json({
        success: false,
        detail: "Active ICMTA membership required",
      });
    }

    return next();
  });
}

// Export both middleware functions so routes can choose the required access level.
module.exports = {
  requireAuth,
  requireMember,
};
