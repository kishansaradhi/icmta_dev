import logging
from datetime import datetime, timezone
from pathlib import Path
from uuid import uuid4
from fastapi import APIRouter, Depends, File, Form, HTTPException, UploadFile
from sqlalchemy import desc, select
from sqlalchemy.orm import Session

from app.core.config import settings
from app.core.database import get_db
from app.models.membership_application import MembershipApplication
from app.models.membership_payment import MembershipPayment
from app.schemas.payment import (
    PaymentCreate,
    PaymentResponse,
)
from app.services.payment_service import (
    calculate_membership_fee,
    validate_payment_reference,
)

logger = logging.getLogger("uvicorn.error")

router = APIRouter(tags=["Payments"])


async def _save_payment_proof(upload: UploadFile) -> str:
    allowed_mimes = {
        "image/jpeg",
        "image/png",
        "image/webp",
        "application/pdf",
    }
    if upload.content_type not in allowed_mimes:
        raise HTTPException(
            status_code=400,
            detail="Payment proof must be a JPG, PNG, WEBP, or PDF file.",
        )

    content = await upload.read()
    if len(content) == 0:
        raise HTTPException(
            status_code=400,
            detail="Uploaded payment proof file is empty.",
        )
    if len(content) > 10 * 1024 * 1024:
        raise HTTPException(
            status_code=400,
            detail="Payment proof file size must be 10 MB or smaller.",
        )

    suffix = Path(upload.filename or "").suffix.lower()
    if suffix not in {".jpg", ".jpeg", ".png", ".webp", ".pdf"}:
        raise HTTPException(
            status_code=400,
            detail="Payment proof has an unsupported extension. Allowed: .jpg, .jpeg, .png, .webp, .pdf",
        )

    # Safe unique filename preventing path traversal
    filename = f"proof_{uuid4().hex}{suffix}"
    folder = Path(settings.upload_dir) / "payment_proofs"
    folder.mkdir(parents=True, exist_ok=True)
    path = folder / filename
    path.write_bytes(content)

    return f"/uploads/payment_proofs/{filename}"


@router.post("/payments/manual-submission")
async def submit_manual_payment(
    application_id: int = Form(...),
    transaction_id: str = Form(...),
    payment_method: str = Form("PhonePe UPI"),
    client_submission_id: str | None = Form(None),
    proof: UploadFile | None = File(None),
    db: Session = Depends(get_db),
):
    req_id = f"pay_req_{uuid4().hex[:8]}"
    txn_clean = transaction_id.strip()

    logger.info(
        f"=== [PAYMENT CREATE REQUEST START] req_id={req_id} app_id={application_id} "
        f"txn='{txn_clean}' sub_id={client_submission_id} ==="
    )

    application = db.get(MembershipApplication, application_id)
    if not application:
        logger.warning(f"[PAYMENT REJECTED] req_id={req_id} Application #{application_id} not found")
        raise HTTPException(
            status_code=404,
            detail=f"Membership application #{application_id} was not found.",
        )

    txn_clean = transaction_id.strip()
    if not txn_clean or len(txn_clean) < 4:
        raise HTTPException(
            status_code=400,
            detail="Please provide a valid PhonePe Transaction ID or UTR number.",
        )

    # Server-side canonical fee calculation
    try:
        amount = calculate_membership_fee(application.membership_category)
    except ValueError as exc:
        raise HTTPException(status_code=400, detail=str(exc))

    # Prevent submitting if application is already verified as Paid
    existing_paid = db.execute(
        select(MembershipPayment).where(
            MembershipPayment.application_id == application_id,
            MembershipPayment.payment_status == "Paid",
        )
    ).scalars().first()
    if existing_paid:
        raise HTTPException(
            status_code=400,
            detail="This membership application has already been paid and verified.",
        )

    # Check for duplicate transaction_id across all payments
    existing_txn = db.execute(
        select(MembershipPayment).where(
            MembershipPayment.transaction_id == txn_clean
        )
    ).scalars().first()
    if existing_txn and existing_txn.application_id != application_id:
        raise HTTPException(
            status_code=409,
            detail=f"Transaction ID / UTR '{txn_clean}' has already been submitted for another application.",
        )

    # Save payment proof file if provided
    proof_url = None
    if proof and proof.filename:
        proof_url = await _save_payment_proof(proof)
        existing_notes = application.admin_notes or ""
        note_entry = f"[Payment Proof: {proof_url}]"
        if note_entry not in existing_notes:
            application.admin_notes = f"{existing_notes}\n{note_entry}".strip()

    now = datetime.now(timezone.utc).replace(tzinfo=None)

    # Check if there is already a Pending payment for this application
    pending_payment = db.execute(
        select(MembershipPayment).where(
            MembershipPayment.application_id == application_id,
            MembershipPayment.payment_status == "Pending",
        )
    ).scalars().first()

    if pending_payment:
        pending_payment.transaction_id = txn_clean
        pending_payment.payment_method = payment_method.strip() or "PhonePe UPI"
        pending_payment.payment_gateway = "PhonePe QR"
        pending_payment.amount = amount
        pending_payment.currency = "INR"
        pending_payment.updated_at = now
        payment_record = pending_payment
    else:
        payment_record = MembershipPayment(
            application_id=application.application_id,
            member_id=application.member_id,
            membership_category=application.membership_category,
            amount=amount,
            currency="INR",
            payment_method=payment_method.strip() or "PhonePe UPI",
            payment_gateway="PhonePe QR",
            transaction_id=txn_clean,
            payment_status="Pending",
            paid_at=None,
            created_at=now,
            updated_at=now,
        )
        db.add(payment_record)

    db.commit()
    db.refresh(payment_record)

    logger.info(
        f"=== [PAYMENT CREATE REQUEST END] req_id={req_id} pay_id={payment_record.payment_id} "
        f"app_id={payment_record.application_id} status={payment_record.payment_status} ==="
    )

    return {
        "success": True,
        "message": "Payment details submitted successfully. Waiting for administrative verification.",
        "data": {
            "payment_id": payment_record.payment_id,
            "application_id": payment_record.application_id,
            "transaction_id": payment_record.transaction_id,
            "payment_status": payment_record.payment_status,
            "amount": float(payment_record.amount),
            "currency": payment_record.currency,
            "payment_method": payment_record.payment_method,
            "payment_gateway": payment_record.payment_gateway,
            "proof_url": proof_url,
            "created_at": payment_record.created_at.isoformat() if payment_record.created_at else None,
        },
    }


@router.post("/payments")
def create_payment(
    payload: PaymentCreate,
    db: Session = Depends(get_db),
):
    """
    Public payment submission endpoint.
    Payment status is strictly forced to 'Pending' for administrative verification.
    Amount is validated server-side.
    """
    if not payload.application_id:
        raise HTTPException(status_code=400, detail="application_id is required.")

    application = db.get(MembershipApplication, payload.application_id)
    if not application:
        raise HTTPException(
            status_code=404,
            detail=f"Membership application #{payload.application_id} was not found.",
        )

    txn_clean = (payload.transaction_id or "").strip()
    if not txn_clean or len(txn_clean) < 4:
        raise HTTPException(
            status_code=400,
            detail="A valid transaction / UTR reference number is required.",
        )

    # Server-side canonical fee calculation
    try:
        canonical_amount = calculate_membership_fee(application.membership_category)
    except ValueError as exc:
        raise HTTPException(status_code=400, detail=str(exc))

    # Prevent submitting if already Paid
    existing_paid = db.execute(
        select(MembershipPayment).where(
            MembershipPayment.application_id == payload.application_id,
            MembershipPayment.payment_status == "Paid",
        )
    ).scalars().first()
    if existing_paid:
        raise HTTPException(
            status_code=400,
            detail="This membership application has already been paid and verified.",
        )

    # Check for duplicate transaction_id across all payments
    existing_txn = db.execute(
        select(MembershipPayment).where(
            MembershipPayment.transaction_id == txn_clean
        )
    ).scalars().first()
    if existing_txn and existing_txn.application_id != payload.application_id:
        raise HTTPException(
            status_code=409,
            detail=f"Transaction ID / UTR '{txn_clean}' has already been submitted for another application.",
        )

    now = datetime.now(timezone.utc).replace(tzinfo=None)

    # Prevent duplicate payment records on double submission
    pending_payment = db.execute(
        select(MembershipPayment).where(
            MembershipPayment.application_id == payload.application_id,
            MembershipPayment.payment_status == "Pending",
        )
    ).scalars().first()

    if pending_payment:
        pending_payment.transaction_id = txn_clean
        pending_payment.payment_method = payload.payment_method or "PhonePe UPI"
        pending_payment.payment_gateway = payload.payment_gateway or "PhonePe QR"
        pending_payment.amount = canonical_amount
        pending_payment.currency = "INR"
        pending_payment.updated_at = now
        payment_record = pending_payment
    else:
        payment_record = MembershipPayment(
            application_id=payload.application_id,
            member_id=application.member_id,
            membership_category=application.membership_category,
            amount=canonical_amount,
            currency="INR",
            payment_method=payload.payment_method or "PhonePe UPI",
            payment_gateway=payload.payment_gateway or "PhonePe QR",
            transaction_id=txn_clean,
            payment_status="Pending",  # Strictly Pending for public submissions
            paid_at=None,
            created_at=now,
            updated_at=now,
        )
        db.add(payment_record)

    db.commit()
    db.refresh(payment_record)

    return {
        "success": True,
        "message": "Payment details submitted successfully and are pending verification.",
        "data": PaymentResponse.model_validate(payment_record).model_dump(mode="json"),
    }


@router.get("/payments/{payment_id}")
def get_payment(payment_id: int, db: Session = Depends(get_db)):
    payment = db.get(MembershipPayment, payment_id)
    if not payment:
        raise HTTPException(status_code=404, detail="Payment not found")

    return {
        "success": True,
        "data": PaymentResponse.model_validate(payment).model_dump(mode="json"),
    }


@router.get("/payments/application/{application_id}")
def get_application_payment_details(
    application_id: int,
    db: Session = Depends(get_db),
):
    """Retrieve application summary and calculate verified canonical fee from backend."""
    application = db.get(MembershipApplication, application_id)
    if not application:
        raise HTTPException(
            status_code=404,
            detail=f"Membership application #{application_id} was not found.",
        )

    try:
        amount = calculate_membership_fee(application.membership_category)
    except ValueError as exc:
        raise HTTPException(
            status_code=400,
            detail=str(exc),
        )

    # Check for existing payments for this application
    payments_stmt = (
        select(MembershipPayment)
        .where(MembershipPayment.application_id == application_id)
        .order_by(desc(MembershipPayment.payment_id))
    )
    existing_payments = db.execute(payments_stmt).scalars().all()

    paid_payment = next(
        (p for p in existing_payments if p.payment_status == "Paid"),
        None,
    )
    latest_payment = existing_payments[0] if existing_payments else None

    payment_status = "Unpaid"
    active_payment = None
    if paid_payment:
        payment_status = "Paid"
        active_payment = paid_payment
    elif latest_payment and latest_payment.payment_status in {"Pending", "Failed"}:
        payment_status = latest_payment.payment_status
        active_payment = latest_payment

    return {
        "success": True,
        "data": {
            "application_id": application.application_id,
            "member_id": application.member_id,
            "full_name": application.full_name,
            "membership_category": application.membership_category,
            "amount": amount,
            "currency": "INR",
            "approval_status": application.approval_status,
            "payment_status": payment_status,
            "is_paid": bool(paid_payment),
            "paid_at": paid_payment.paid_at.isoformat() if paid_payment and paid_payment.paid_at else None,
            "payment_id": active_payment.payment_id if active_payment else None,
            "transaction_id": active_payment.transaction_id if active_payment else None,
            "payment_method": active_payment.payment_method if active_payment else None,
            "payment_gateway": active_payment.payment_gateway if active_payment else None,
            "submitted_at": active_payment.created_at.isoformat() if active_payment and active_payment.created_at else None,
        },
    }
