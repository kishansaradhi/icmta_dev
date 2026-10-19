const express = require("express");
const multer = require("multer");
const { query, getConnection } = require("../db/pool");
const { calculateMembershipFee } = require("../services/paymentService");
const { saveUploadedFile } = require("../utils/uploads");
const { cleanString } = require("../utils/validation");

const router = express.Router();
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 10 * 1024 * 1024 },
});

function paymentProofFromNotes(notes) {
  const m = String(notes || "").match(/\[Payment Proof:\s*([^\]]+)\]/);
  return m ? m[1].trim() : null;
}

async function createOrUpdatePayment({ applicationId, transactionId, paymentMethod, proofFile }) {
  const apps = await query(
    "SELECT * FROM membership_applications WHERE application_id = ? LIMIT 1",
    [applicationId]
  );
  const app = apps[0];
  if (!app) {
    const e = new Error(`Membership application #${applicationId} was not found.`);
    e.statusCode = 404;
    throw e;
  }

  const txn = String(transactionId || "").trim();
  if (txn.length < 4) {
    const e = new Error("Please provide a valid PhonePe Transaction ID or UTR number.");
    e.statusCode = 400;
    throw e;
  }

  const amount = calculateMembershipFee(app.membership_category);

  const paid = await query(
    "SELECT payment_id FROM membership_payments WHERE application_id = ? AND payment_status = 'Paid' LIMIT 1",
    [applicationId]
  );
  if (paid.length) {
    const e = new Error("This membership application has already been paid and verified.");
    e.statusCode = 400;
    throw e;
  }

  const duplicate = await query(
    "SELECT payment_id, application_id FROM membership_payments WHERE transaction_id = ? LIMIT 1",
    [txn]
  );
  if (duplicate.length && Number(duplicate[0].application_id) !== Number(applicationId)) {
    const e = new Error(`Transaction ID / UTR '${txn}' has already been submitted for another application.`);
    e.statusCode = 409;
    throw e;
  }

  const proofUrl = proofFile
    ? saveUploadedFile(
        proofFile,
        "payment_proofs",
        ["image/jpeg", "image/png", "image/webp", "application/pdf"],
        10 * 1024 * 1024
      )
    : null;

  const now = new Date();
  const notesAdd = proofUrl ? `[Payment Proof: ${proofUrl}]` : null;

  const pending = await query(
    "SELECT * FROM membership_payments WHERE application_id = ? AND payment_status = 'Pending' ORDER BY payment_id DESC LIMIT 1",
    [applicationId]
  );

  let paymentId;
  if (pending.length) {
    paymentId = pending[0].payment_id;
    await query(`
      UPDATE membership_payments
      SET transaction_id=?, payment_method=?, payment_gateway='PhonePe QR',
          amount=?, currency='INR', updated_at=CURRENT_TIMESTAMP
      WHERE payment_id=?
    `, [txn, cleanString(paymentMethod) || "PhonePe UPI", amount, paymentId]);
  } else {
    const result = await query(`
      INSERT INTO membership_payments
        (application_id,member_id,membership_category,amount,currency,
         payment_method,payment_gateway,transaction_id,payment_status,paid_at)
      VALUES (?,?,?,?,?,?,?,?, 'Pending', NULL)
    `, [
      applicationId, app.member_id, app.membership_category, amount, "INR",
      cleanString(paymentMethod) || "PhonePe UPI", "PhonePe QR", txn
    ]);
    paymentId = result.insertId;
  }

  if (notesAdd) {
    const current = app.admin_notes || "";
    if (!current.includes(notesAdd)) {
      await query(
        "UPDATE membership_applications SET admin_notes = ? WHERE application_id = ?",
        [current ? `${current}\n${notesAdd}` : notesAdd, applicationId]
      );
    }
  }

  const rows = await query("SELECT * FROM membership_payments WHERE payment_id = ?", [paymentId]);
  return { payment: rows[0], proof_url: proofUrl };
}

router.post("/payments/manual-submission", upload.single("proof"), async (req, res, next) => {
  try {
    const result = await createOrUpdatePayment({
      applicationId: Number(req.body.application_id),
      transactionId: req.body.transaction_id,
      paymentMethod: req.body.payment_method || "PhonePe UPI",
      proofFile: req.file,
    });

    const p = result.payment;
    res.json({
      success: true,
      message: "Payment details submitted successfully. Waiting for administrative verification.",
      data: {
        payment_id: p.payment_id,
        application_id: p.application_id,
        transaction_id: p.transaction_id,
        payment_status: p.payment_status,
        amount: Number(p.amount),
        currency: p.currency,
        payment_method: p.payment_method,
        payment_gateway: p.payment_gateway,
        proof_url: result.proof_url,
        created_at: p.created_at,
      },
    });
  } catch (err) {
    next(err);
  }
});

router.post("/payments", async (req, res, next) => {
  try {
    const result = await createOrUpdatePayment({
      applicationId: Number(req.body?.application_id),
      transactionId: req.body?.transaction_id,
      paymentMethod: req.body?.payment_method,
      proofFile: null,
    });
    res.json({
      success: true,
      message: "Payment details submitted successfully and are pending verification.",
      data: {
        ...result.payment,
        amount: Number(result.payment.amount),
      },
    });
  } catch (err) {
    next(err);
  }
});

router.get("/payments/:payment_id", async (req, res, next) => {
  try {
    const rows = await query("SELECT * FROM membership_payments WHERE payment_id = ? LIMIT 1", [
      Number(req.params.payment_id),
    ]);
    if (!rows.length) return res.status(404).json({ detail: "Payment not found" });
    res.json({ success: true, data: { ...rows[0], amount: Number(rows[0].amount) } });
  } catch (err) {
    next(err);
  }
});

router.get("/payments/application/:application_id", async (req, res, next) => {
  try {
    const applicationId = Number(req.params.application_id);
    const apps = await query("SELECT * FROM membership_applications WHERE application_id = ?", [applicationId]);
    if (!apps.length) return res.status(404).json({ detail: `Membership application #${applicationId} was not found.` });

    const app = apps[0];
    const amount = calculateMembershipFee(app.membership_category);
    const payments = await query(
      "SELECT * FROM membership_payments WHERE application_id = ? ORDER BY payment_id DESC",
      [applicationId]
    );

    const paid = payments.find((p) => p.payment_status === "Paid");
    const latest = payments[0];
    const active = paid || latest || null;
    const paymentStatus = paid ? "Paid" : latest && ["Pending", "Failed"].includes(latest.payment_status) ? latest.payment_status : "Unpaid";

    res.json({
      success: true,
      data: {
        application_id: app.application_id,
        member_id: app.member_id,
        full_name: app.full_name,
        membership_category: app.membership_category,
        amount,
        currency: "INR",
        approval_status: app.approval_status,
        payment_status: paymentStatus,
        is_paid: !!paid,
        paid_at: paid?.paid_at || null,
        payment_id: active?.payment_id || null,
        transaction_id: active?.transaction_id || null,
        payment_method: active?.payment_method || null,
        payment_gateway: active?.payment_gateway || null,
        submitted_at: active?.created_at || null,
      },
    });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
