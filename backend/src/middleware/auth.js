const jwt = require("jsonwebtoken");
const { query } = require("../db/pool");
const config = require("../config/env");

async function requireAdmin(req, res, next) {
  try {
    const header = req.headers.authorization || "";
    if (!header.startsWith("Bearer ")) {
      return res.status(401).json({ detail: "Authentication required" });
    }

    if (!config.jwt.secret) {
      return res.status(500).json({ detail: "JWT_SECRET is not configured" });
    }

    const token = header.slice(7);
    const payload = jwt.verify(token, config.jwt.secret, {
      algorithms: ["HS256"],
    });

    if (payload.role !== "admin" || !payload.sub) {
      return res.status(401).json({ detail: "Invalid or expired token" });
    }

    const rows = await query(
      "SELECT admin_id, user_id, is_active FROM admin_users WHERE admin_id = ? LIMIT 1",
      [Number(payload.sub)]
    );
    const admin = rows[0];

    if (!admin || !admin.is_active) {
      return res.status(401).json({ detail: "Admin account is inactive or missing" });
    }

    req.admin = admin;
    req.jwt = payload;
    next();
  } catch (err) {
    return res.status(401).json({ detail: "Invalid or expired token" });
  }
}

module.exports = { requireAdmin };
