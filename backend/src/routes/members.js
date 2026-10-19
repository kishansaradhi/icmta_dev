
const express = require("express");
const { query } = require("../db/pool");
const { getMemberById } = require("../services/memberQueries");
const { cleanString, cleanEmail } = require("../utils/validation");
const { requireAuth, requireMember } = require("../middleware/memberAuth");

const router = express.Router();

// Reuse the existing directory filters for both account types.
function getDirectoryFilters(req) {
  const q = cleanString(req.query.q);
  const state = cleanString(req.query.state);
  const department = cleanString(req.query.department);
  const search = q ? `%${q}%` : null;

  return {
    search,
    state,
    department,
    params: [
      search, search, search, search, search, search, search,
      state, state,
      department, department,
    ],
  };
}

// Registered users can browse the directory, but contact details and
// other full-profile fields are reserved for active ICMTA members.
router.get("/members", requireAuth, async (req, res, next) => {
  try {
    const { search, state, department, params } = getDirectoryFilters(req);

    if (req.memberAuth.is_admin || req.memberAuth.is_member) {
      // Active members receive the existing full directory data.
      const rows = await query(`
        SELECT
          m.member_id, m.academic_title, m.name,
          a.date_of_birth, a.qualification,
          m.designation, m.department, m.institution,
          c.address, c.city, c.state_province, c.pin_code, c.country,
          a.research_guideship, a.expertise,
          c.mobile, c.whatsapp, c.whatsapp_secondary,
          c.professional_email, c.personal_email,
          a.linkedin, a.orcid, a.google_scholar, a.photo_url,
          m.membership_category, m.is_active, a.source_record,
          m.my_status, m.created_at, m.updated_at
        FROM members m
        LEFT JOIN member_contact_info c
          ON m.member_id = c.member_id
        LEFT JOIN member_academic_profile a
          ON m.member_id = a.member_id
        WHERE (
          ? IS NULL OR
          m.name LIKE ? OR m.member_id LIKE ? OR m.institution LIKE ? OR
          m.designation LIKE ? OR m.department LIKE ? OR a.expertise LIKE ?
        )
        AND (? IS NULL OR c.state_province = ?)
        AND (? IS NULL OR m.department = ?)
        ORDER BY m.member_id ASC
      `, params);

      return res.json({
        success: true,
        data: rows,
        count: rows.length,
        account_type: "member",
      });
    }

    // Registered non-members receive only basic directory information.
    // Do not return phone numbers, email addresses, birth dates, or addresses.
    const rows = await query(`
      SELECT
        m.member_id,
        m.academic_title,
        m.name,
        m.designation,
        m.department,
        m.institution,
        c.city,
        c.state_province,
        c.country,
        a.expertise,
        a.photo_url
      FROM members m
      LEFT JOIN member_contact_info c
        ON m.member_id = c.member_id
      LEFT JOIN member_academic_profile a
        ON m.member_id = a.member_id
      WHERE (
        ? IS NULL OR
        m.name LIKE ? OR m.member_id LIKE ? OR m.institution LIKE ? OR
        m.designation LIKE ? OR m.department LIKE ? OR a.expertise LIKE ?
      )
      AND (? IS NULL OR c.state_province = ?)
      AND (? IS NULL OR m.department = ?)
      ORDER BY m.member_id ASC
    `, params);

    return res.json({
      success: true,
      data: rows,
      count: rows.length,
      account_type: "registered",
    });
  } catch (err) {
    next(err);
  }
});

// Individual profiles contain protected information and require active membership.
router.get("/members/:member_id", requireMember, async (req, res, next) => {
  try {
    const member = await getMemberById(query, req.params.member_id, true);

    if (!member) {
      return res.status(404).json({
        success: false,
        detail: "Member not found or inactive.",
      });
    }

    return res.json({ success: true, data: member });
  } catch (err) {
    next(err);
  }
});

// Keep the existing membership-verification workflow available to logged-in
// users, without allowing unauthenticated requests to retrieve member details.
router.post("/members/verify", requireAuth, async (req, res, next) => {
  try {
    const memberId = cleanString(req.body?.member_id);
    const email = cleanEmail(req.body?.email);

    if (!memberId || !email) {
      return res.status(400).json({
        success: false,
        detail: "Member ID and registered email are required.",
      });
    }

    const rows = await query(`
      SELECT
        m.member_id, m.academic_title, m.name, m.designation, m.department,
        m.institution, m.membership_category, m.is_active, m.my_status,
        c.personal_email, c.professional_email, c.mobile, c.whatsapp,
        c.whatsapp_secondary, c.address, c.city, c.state_province,
        c.pin_code, c.country,
        a.date_of_birth, a.qualification, a.research_guideship, a.expertise,
        a.linkedin, a.orcid, a.google_scholar, a.photo_url
      FROM members m
      LEFT JOIN member_contact_info c
        ON m.member_id = c.member_id
      LEFT JOIN member_academic_profile a
        ON m.member_id = a.member_id
      WHERE UPPER(TRIM(m.member_id)) = UPPER(?)
        AND (
          (c.personal_email IS NOT NULL
            AND LOWER(TRIM(c.personal_email)) = ?)
          OR
          (c.professional_email IS NOT NULL
            AND LOWER(TRIM(c.professional_email)) = ?)
        )
      LIMIT 1
    `, [memberId, email, email]);

    if (!rows.length) {
      return res.status(404).json({
        success: false,
        detail: "Member not found. Please check your Member ID and registered email.",
      });
    }

    const row = rows[0];

    // Preserve the existing response structure used by the application form.
    const matchedEmail =
      row.professional_email &&
      row.professional_email.toLowerCase() === email
        ? row.professional_email
        : row.personal_email || email;

    return res.json({
      success: true,
      message: "Member verified successfully.",
      data: {
        member_id: row.member_id,
        academic_title: row.academic_title,
        name: row.name,
        designation: row.designation,
        department: row.department,
        institution: row.institution,
        current_membership_category: row.membership_category,
        registered_email: matchedEmail,
        personal_email: row.personal_email,
        professional_email: row.professional_email,
        mobile: row.mobile,
        whatsapp: row.whatsapp,
        whatsapp_secondary: row.whatsapp_secondary,
        address: row.address,
        city: row.city,
        state_province: row.state_province,
        pin_code: row.pin_code,
        country: row.country || "India",
        date_of_birth: row.date_of_birth,
        qualification: row.qualification,
        research_guideship: row.research_guideship,
        expertise: row.expertise,
        google_scholar: row.google_scholar,
        linkedin: row.linkedin,
        orcid: row.orcid,
        photo_url: row.photo_url,
      },
    });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
