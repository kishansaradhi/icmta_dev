const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { query } = require("../db/pool");
const { requireAdmin } = require("../middleware/auth");
const config = require("../config/env");

const router = express.Router();

router.post("/admin/login", async (req, res, next) => {
  try {
    const userId = String(req.body?.user_id || "").trim();
    const password = String(req.body?.password || "");

    const rows = await query(
      "SELECT admin_id, user_id, password_hash, is_active FROM admin_users WHERE user_id = ? LIMIT 1",
      [userId]
    );
    const admin = rows[0];

    if (!admin || !admin.is_active || !(await bcrypt.compare(password, admin.password_hash))) {
      return res.status(401).json({ detail: "Invalid credentials" });
    }

    if (!config.jwt.secret) {
      return res.status(500).json({ detail: "JWT_SECRET is not configured" });
    }

    const token = jwt.sign(
      { sub: String(admin.admin_id), user_id: admin.user_id, role: "admin" },
      config.jwt.secret,
      { expiresIn: config.jwt.expiresIn, algorithm: "HS256" }
    );

    res.json({
      success: true,
      token,
      data: { admin_id: admin.admin_id, user_id: admin.user_id },
    });
  } catch (err) {
    next(err);
  }
});

router.get("/admin/me", requireAdmin, async (req, res) => {
  res.json({
    success: true,
    data: {
      admin_id: req.admin.admin_id,
      user_id: req.admin.user_id,
      is_active: !!req.admin.is_active,
    },
  });
});

module.exports = router;
