const express = require("express");
const multer = require("multer");
const { query, getConnection } = require("../db/pool");
const { nextMemberId } = require("../services/memberService");
const { calculateMembershipFee } = require("../services/paymentService");
const { saveUploadedFile } = require("../utils/uploads");
const { cleanString, cleanEmail, parseDate, isFutureDate } = require("../utils/validation");

const router = express.Router();
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 5 * 1024 * 1024 },
});

function paymentProofFromNotes(notes) {
  const m = String(notes || "").match(/\[Payment Proof:\s*([^\]]+)\]/);
  return m ? m[1].trim() : null;
}

async function getApplication(applicationId) {
  const rows = await query(`
    SELECT
      ma.application_id, ma.member_id, ma.membership_category, ma.full_name,
      ma.approval_status, ma.admin_notes, ma.reviewed_by, ma.reviewed_at,
      ma.created_at, ma.updated_at,
      ai.academic_title, ai.date_of_birth, ai.highest_qualification,
      ai.designation, ai.department, ai.institution, ai.college_address,
      ai.pin_code, ai.state_province, ai.country,
      ac.personal_email, ac.professional_email, ac.mobile, ac.whatsapp,
      ac.whatsapp_secondary, ac.photo_url, ac.google_scholar, ac.linkedin,
      ac.orcid, ac.expertise, ac.research_guideship
    FROM membership_applications ma
    LEFT JOIN application_applicant_info ai ON ma.application_id = ai.application_id
    LEFT JOIN application_contact_info ac ON ma.application_id = ac.application_id
    WHERE ma.application_id = ?
    LIMIT 1
  `, [applicationId]);
  return rows[0] || null;
}

const submitMembershipApplication = async (req, res, next) => {
  let conn;
  try {
    const b = req.body || {};
    const fullName = cleanString(b.full_name);
    const category = cleanString(b.membership_category);

    if (!fullName) return res.status(400).json({ detail: "Full name is required." });
    if (!category) return res.status(400).json({ detail: "Membership category is required." });

    const dob = parseDate(b.date_of_birth);
    if (b.date_of_birth && !dob) {
      return res.status(400).json({ detail: "Invalid date of birth. Use YYYY-MM-DD or DD/MM/YYYY." });
    }
    if (dob && isFutureDate(dob)) {
      return res.status(400).json({ detail: "Date of birth cannot be in the future." });
    }

    const personalEmail = cleanEmail(b.personal_email);
    const professionalEmail = cleanEmail(b.professional_email);
    const memberId = cleanString(b.member_id);
    const submissionId = cleanString(b.client_submission_id);

    // Idempotency by client submission ID.
    if (submissionId) {
      const rows = await query(
        "SELECT application_id, approval_status FROM membership_applications WHERE admin_notes LIKE ? ORDER BY application_id DESC LIMIT 1",
        [`%[Submission: ${submissionId}]%`]
      );
      if (rows.length) {
        return res.json({
          success: true,
          application_id: rows[0].application_id,
          message: "Application already submitted and awaiting review.",
          data: {
            application_id: rows[0].application_id,
            approval_status: rows[0].approval_status,
            message: "Existing application returned (idempotent)",
          },
        });
      }
    }

    // Prevent accidental rapid duplicate submissions.
    if (personalEmail || professionalEmail) {
      const rows = await query(`
        SELECT ma.application_id, ma.approval_status
        FROM membership_applications ma
        JOIN application_contact_info ac ON ma.application_id = ac.application_id
        WHERE ma.approval_status = 'Pending'
          AND ma.created_at >= (NOW() - INTERVAL 10 MINUTE)
          AND (
            (? IS NOT NULL AND ac.personal_email = ?)
            OR (? IS NOT NULL AND ac.professional_email = ?)
          )
        ORDER BY ma.application_id DESC
        LIMIT 1
      `, [personalEmail, personalEmail, professionalEmail, professionalEmail]);

      if (rows.length) {
        return res.json({
          success: true,
          application_id: rows[0].application_id,
          message: "Application already submitted and awaiting admin review.",
          data: {
            application_id: rows[0].application_id,
            approval_status: rows[0].approval_status,
            message: "Application submitted successfully",
          },
        });
      }
    }

    // Existing member validation + field preservation.
    let existing = null;
    if (memberId) {
      const rows = await query(`
        SELECT
          m.member_id, m.academic_title, m.name, m.designation, m.department, m.institution,
          c.personal_email, c.professional_email, c.mobile, c.whatsapp, c.whatsapp_secondary,
          c.address, c.city, c.state_province, c.pin_code, c.country,
          a.date_of_birth, a.qualification, a.research_guideship, a.expertise,
          a.linkedin, a.orcid, a.google_scholar, a.photo_url
        FROM members m
        LEFT JOIN member_contact_info c ON m.member_id = c.member_id
        LEFT JOIN member_academic_profile a ON m.member_id = a.member_id
        WHERE UPPER(TRIM(m.member_id)) = UPPER(TRIM(?))
        LIMIT 1
      `, [memberId]);

      if (!rows.length) return res.status(400).json({ detail: "Existing member ID was not found." });
      existing = rows[0];

      b.academic_title ||= existing.academic_title;
      if (!dob) b.date_of_birth = existing.date_of_birth;
      b.highest_qualification ||= existing.qualification;
      b.designation ||= existing.designation;
      b.department ||= existing.department;
      b.institution ||= existing.institution;
      b.college_address ||= existing.address;
      b.pin_code ||= existing.pin_code;
      b.state_province ||= existing.state_province;
      b.country ||= existing.country;
      b.mobile ||= existing.mobile;
      b.whatsapp ||= existing.whatsapp;
      b.whatsapp_secondary ||= existing.whatsapp_secondary;
      b.google_scholar ||= existing.google_scholar;
      b.linkedin ||= existing.linkedin;
      b.orcid ||= existing.orcid;
      b.expertise ||= existing.expertise;
      b.research_guideship ||= existing.research_guideship;
    }

    let photoUrl = null;
    if (req.file) {
      photoUrl = saveUploadedFile(
        req.file,
        "member_photos",
        ["image/jpeg", "image/png", "image/webp"],
        5 * 1024 * 1024
      );
    } else if (existing?.photo_url) {
      photoUrl = existing.photo_url;
    }

    // Existing member: update the current pending application instead of duplicating it.
    if (memberId) {
      const pending = await query(`
        SELECT application_id
        FROM membership_applications
        WHERE member_id = ? AND approval_status = 'Pending'
        ORDER BY application_id DESC LIMIT 1
      `, [memberId]);

      if (pending.length) {
        const applicationId = pending[0].application_id;
        await query(`
          UPDATE membership_applications
          SET membership_category=?, full_name=?, admin_notes=?
          WHERE application_id=?
        `, [
          category,
          fullName,
          submissionId ? `[Submission: ${submissionId}]` : null,
          applicationId,
        ]);

        await query(`
          UPDATE application_applicant_info SET
            academic_title=?, date_of_birth=?, highest_qualification=?, designation=?,
            department=?, institution=?, college_address=?, pin_code=?,
            state_province=?, country=?
          WHERE application_id=?
        `, [
          cleanString(b.academic_title), parseDate(b.date_of_birth) || b.date_of_birth || null,
          cleanString(b.highest_qualification), cleanString(b.designation),
          cleanString(b.department), cleanString(b.institution),
          cleanString(b.college_address), cleanString(b.pin_code),
          cleanString(b.state_province), cleanString(b.country),
          applicationId,
        ]);

        await query(`
          UPDATE application_contact_info SET
            personal_email=?, professional_email=?, mobile=?, whatsapp=?,
            whatsapp_secondary=?, photo_url=?, google_scholar=?, linkedin=?,
            orcid=?, expertise=?, research_guideship=?
          WHERE application_id=?
        `, [
          personalEmail || existing?.personal_email || null,
          professionalEmail || existing?.professional_email || null,
          cleanString(b.mobile), cleanString(b.whatsapp), cleanString(b.whatsapp_secondary),
          photoUrl, cleanString(b.google_scholar), cleanString(b.linkedin),
          cleanString(b.orcid), cleanString(b.expertise), cleanString(b.research_guideship),
          applicationId,
        ]);

        return res.json({
          success: true,
          application_id: applicationId,
          message: "Application updated and awaiting review.",
          data: {
            application_id: applicationId,
            approval_status: "Pending",
            message: "Application updated successfully (idempotent)",
          },
        });
      }
    }

    conn = await getConnection();
    await conn.beginTransaction();

    const [appResult] = await conn.execute(`
      INSERT INTO membership_applications
        (member_id,membership_category,full_name,approval_status,admin_notes)
      VALUES (?,?,?,'Pending',?)
    `, [
      memberId || null,
      category,
      fullName,
      submissionId ? `[Submission: ${submissionId}]` : null,
    ]);

    const applicationId = appResult.insertId;

    await conn.execute(`
      INSERT INTO application_applicant_info
        (application_id,academic_title,date_of_birth,highest_qualification,
         designation,department,institution,college_address,pin_code,state_province,country)
      VALUES (?,?,?,?,?,?,?,?,?,?,?)
    `, [
      applicationId, cleanString(b.academic_title), dob || b.date_of_birth || null,
      cleanString(b.highest_qualification), cleanString(b.designation),
      cleanString(b.department), cleanString(b.institution),
      cleanString(b.college_address), cleanString(b.pin_code),
      cleanString(b.state_province), cleanString(b.country),
    ]);

    await conn.execute(`
      INSERT INTO application_contact_info
        (application_id,personal_email,professional_email,mobile,whatsapp,
         whatsapp_secondary,photo_url,google_scholar,linkedin,orcid,expertise,research_guideship)
      VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
    `, [
      applicationId, personalEmail, professionalEmail, cleanString(b.mobile),
      cleanString(b.whatsapp), cleanString(b.whatsapp_secondary), photoUrl,
      cleanString(b.google_scholar), cleanString(b.linkedin), cleanString(b.orcid),
      cleanString(b.expertise), cleanString(b.research_guideship),
    ]);

    await conn.commit();

    const app = await getApplication(applicationId);
    res.status(201).json({
      success: true,
      application_id: applicationId,
      message: "Application submitted successfully and is awaiting admin review.",
      data: app,
    });
  } catch (err) {
    if (conn) await conn.rollback();
    next(err);
  } finally {
    if (conn) conn.release();
  }
};

// Public submission endpoints. No admin/member JWT is required to apply for membership.
// The /api/public/... path avoids collisions with any protected admin middleware/proxy rules.
router.post("/membership-applications", upload.single("photo"), submitMembershipApplication);
router.post("/public/membership-applications", upload.single("photo"), submitMembershipApplication);

router.get("/membership-applications/:application_id", async (req, res, next) => {
  try {
    const app = await getApplication(Number(req.params.application_id));
    if (!app) return res.status(404).json({ detail: "Application not found" });

    let amount = null;
    try { amount = calculateMembershipFee(app.membership_category); } catch (_) {}

    res.json({
      success: true,
      data: {
        ...app,
        amount,
        currency: "INR",
        payment_proof: paymentProofFromNotes(app.admin_notes),
      },
    });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
