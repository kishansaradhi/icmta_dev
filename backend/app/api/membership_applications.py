from datetime import date
from pathlib import Path
from uuid import uuid4

from fastapi import APIRouter, Depends, File, Form, HTTPException, UploadFile
from sqlalchemy import text
from sqlalchemy.orm import Session

from app.core.config import settings
from app.core.database import get_db
from app.services.payment_service import calculate_membership_fee

router = APIRouter(tags=["Membership Applications"])


async def save_application_photo(upload: UploadFile | None) -> str | None:
    if not upload:
        return None

    if upload.content_type not in {
        "image/jpeg",
        "image/png",
        "image/webp",
    }:
        raise HTTPException(
            status_code=400,
            detail="Photo must be JPG, PNG, or WEBP.",
        )

    content = await upload.read()

    if len(content) > 5 * 1024 * 1024:
        raise HTTPException(
            status_code=400,
            detail="Photo must be 5 MB or smaller.",
        )

    suffix = Path(upload.filename or "").suffix.lower()

    if suffix not in {".jpg", ".jpeg", ".png", ".webp"}:
        suffix = ".jpg"

    filename = f"{uuid4().hex}{suffix}"

    folder = Path(settings.upload_dir) / "member_photos"
    folder.mkdir(parents=True, exist_ok=True)

    (folder / filename).write_bytes(content)

    return f"/uploads/member_photos/{filename}"


@router.post("/membership-applications")
async def submit_membership_application(
    membership_category: str = Form(...),
    academic_title: str | None = Form(None),
    full_name: str = Form(...),
    date_of_birth: date | None = Form(None),
    personal_email: str | None = Form(None),
    professional_email: str | None = Form(None),
    mobile: str | None = Form(None),
    whatsapp: str | None = Form(None),
    whatsapp_secondary: str | None = Form(None),
    highest_qualification: str | None = Form(None),
    designation: str | None = Form(None),
    department: str | None = Form(None),
    institution: str | None = Form(None),
    college_address: str | None = Form(None),
    pin_code: str | None = Form(None),
    state_province: str | None = Form(None),
    country: str | None = Form(None),
    google_scholar: str | None = Form(None),
    linkedin: str | None = Form(None),
    orcid: str | None = Form(None),
    expertise: str | None = Form(None),
    research_guideship: str | None = Form(None),
    member_id: str | None = Form(None),
    photo: UploadFile | None = File(None),
    db: Session = Depends(get_db),
):
    if not full_name.strip():
        raise HTTPException(
            status_code=400,
            detail="Full name is required.",
        )

    if date_of_birth and date_of_birth > date.today():
        raise HTTPException(
            status_code=400,
            detail="Date of birth cannot be in the future.",
        )

    # Validate existing member if member_id was supplied
    if member_id:
        exists = db.execute(
            text("""
                SELECT member_id
                FROM members
                WHERE member_id = :member_id
            """),
            {"member_id": member_id.strip()},
        ).scalar()

        if not exists:
            raise HTTPException(
                status_code=400,
                detail="Existing member ID was not found.",
            )

    photo_url = await save_application_photo(photo)

    try:
        result = db.execute(
            text("""
                CALL sp_submit_membership_application(
                    :p_member_id,
                    :p_membership_category,
                    :p_full_name,
                    :p_academic_title,
                    :p_date_of_birth,
                    :p_highest_qualification,
                    :p_designation,
                    :p_department,
                    :p_institution,
                    :p_college_address,
                    :p_pin_code,
                    :p_state_province,
                    :p_country,
                    :p_personal_email,
                    :p_professional_email,
                    :p_mobile,
                    :p_whatsapp,
                    :p_whatsapp_secondary,
                    :p_photo_url,
                    :p_google_scholar,
                    :p_linkedin,
                    :p_orcid,
                    :p_expertise,
                    :p_research_guideship
                )
            """),
            {
                "p_member_id": member_id.strip() if member_id else None,
                "p_membership_category": membership_category.strip(),
                "p_full_name": full_name.strip(),
                "p_academic_title": academic_title,
                "p_date_of_birth": date_of_birth,
                "p_highest_qualification": highest_qualification,
                "p_designation": designation,
                "p_department": department,
                "p_institution": institution,
                "p_college_address": college_address,
                "p_pin_code": pin_code,
                "p_state_province": state_province,
                "p_country": country,
                "p_personal_email": personal_email.strip().lower()
                    if personal_email else None,
                "p_professional_email": professional_email.strip().lower()
                    if professional_email else None,
                "p_mobile": mobile,
                "p_whatsapp": whatsapp,
                "p_whatsapp_secondary": whatsapp_secondary,
                "p_photo_url": photo_url,
                "p_google_scholar": google_scholar,
                "p_linkedin": linkedin,
                "p_orcid": orcid,
                "p_expertise": expertise,
                "p_research_guideship": research_guideship,
            },
        )

        row = result.mappings().first()
        db.commit()

        return {
            "success": True,
            "message": "Application submitted successfully and is awaiting admin review.",
            "data": dict(row) if row else None,
        }

    except Exception as exc:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail=str(exc),
        )


@router.get("/membership-applications/{application_id}")
def get_application(
    application_id: int,
    db: Session = Depends(get_db),
):
    result = db.execute(
        text("""
            SELECT
                ma.application_id,
                ma.member_id,
                ma.membership_category,
                ma.full_name,
                ma.approval_status,
                ma.admin_notes,
                ma.reviewed_by,
                ma.reviewed_at,
                ma.created_at,
                ma.updated_at,
                ai.academic_title,
                ai.date_of_birth,
                ai.highest_qualification,
                ai.designation,
                ai.department,
                ai.institution,
                ai.college_address,
                ai.pin_code,
                ai.state_province,
                ai.country,
                ac.personal_email,
                ac.professional_email,
                ac.mobile,
                ac.whatsapp,
                ac.whatsapp_secondary,
                ac.photo_url,
                ac.google_scholar,
                ac.linkedin,
                ac.orcid,
                ac.expertise,
                ac.research_guideship
            FROM membership_applications ma
            LEFT JOIN application_applicant_info ai
                ON ma.application_id = ai.application_id
            LEFT JOIN application_contact_info ac
                ON ma.application_id = ac.application_id
            WHERE ma.application_id = :application_id
        """),
        {"application_id": application_id},
    ).mappings().first()

    if not result:
        raise HTTPException(
            status_code=404,
            detail="Application not found",
        )

    app_data = dict(result)
    try:
        app_data["amount"] = calculate_membership_fee(app_data.get("membership_category"))
        app_data["currency"] = "INR"
    except Exception:
        app_data["amount"] = None
        app_data["currency"] = "INR"

    return {
        "success": True,
        "data": app_data,
    }