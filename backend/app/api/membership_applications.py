import logging
from datetime import date, datetime, timedelta, timezone
from pathlib import Path
from uuid import uuid4

from fastapi import APIRouter, Depends, File, Form, HTTPException, UploadFile
from sqlalchemy import select, text
from sqlalchemy.orm import Session

from app.core.config import settings
from app.core.database import get_db
from app.models.membership_application import MembershipApplication
from app.services.payment_service import calculate_membership_fee

logger = logging.getLogger("uvicorn.error")

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
    date_of_birth: str | None = Form(None),
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
    client_submission_id: str | None = Form(None),
    photo: UploadFile | None = File(None),
    db: Session = Depends(get_db),
):
    req_id = f"app_req_{uuid4().hex[:8]}"
    sub_id_clean = client_submission_id.strip() if client_submission_id else None

    logger.info(
        f"=== [APPLICATION CREATE REQUEST START] req_id={req_id} "
        f"submission_id={sub_id_clean} name='{full_name.strip()}' category='{membership_category.strip()}' ==="
    )

    if not full_name.strip():
        logger.warning(f"[APPLICATION VALIDATION FAILED] req_id={req_id} Full name is missing")
        raise HTTPException(
            status_code=400,
            detail="Full name is required.",
        )

    parsed_dob = None
    if date_of_birth and date_of_birth.strip():
        dob_str = date_of_birth.strip()
        try:
            parsed_dob = date.fromisoformat(dob_str)
        except Exception:
            try:
                parsed_dob = datetime.strptime(dob_str, "%Y-%m-%d").date()
            except Exception:
                try:
                    parsed_dob = datetime.strptime(dob_str, "%d/%m/%Y").date()
                except Exception:
                    pass

    if parsed_dob and parsed_dob > date.today():
        logger.warning(f"[APPLICATION VALIDATION FAILED] req_id={req_id} Date of birth in future: {parsed_dob}")
        raise HTTPException(
            status_code=400,
            detail="Date of birth cannot be in the future.",
        )

    clean_p_email = personal_email.strip().lower() if personal_email else None
    clean_pro_email = professional_email.strip().lower() if professional_email else None

    # Idempotency Check 1: By client_submission_id
    if sub_id_clean:
        existing_by_sub = db.execute(
            select(MembershipApplication).where(
                MembershipApplication.admin_notes.like(f"%[Submission: {sub_id_clean}]%")
            )
        ).scalars().first()
        if existing_by_sub:
            logger.info(
                f"[APPLICATION IDEMPOTENT MATCH] req_id={req_id} matched submission_id={sub_id_clean} "
                f"-> returning existing app_id={existing_by_sub.application_id}"
            )
            logger.info(
                f"=== [APPLICATION CREATE REQUEST END] req_id={req_id} "
                f"app_id={existing_by_sub.application_id} (DEDUPED SUBMISSION ID) ==="
            )
            return {
                "success": True,
                "application_id": existing_by_sub.application_id,
                "message": "Application already submitted and awaiting review.",
                "data": {
                    "application_id": existing_by_sub.application_id,
                    "approval_status": existing_by_sub.approval_status,
                    "message": "Existing application returned (idempotent)",
                },
            }

    # Idempotency Check 2: Recent Pending application with matching emails within 10 minutes
    if clean_p_email or clean_pro_email:
        cutoff_time = datetime.now(timezone.utc).replace(tzinfo=None) - timedelta(minutes=10)
        recent_check_sql = text("""
            SELECT a.application_id, a.approval_status
            FROM membership_applications a
            JOIN application_contact_info c ON a.application_id = c.application_id
            WHERE a.approval_status = 'Pending'
              AND a.created_at >= :cutoff
              AND (
                (:p_email IS NOT NULL AND c.personal_email = :p_email)
                OR (:pro_email IS NOT NULL AND c.professional_email = :pro_email)
              )
            ORDER BY a.application_id DESC
            LIMIT 1
        """)
        recent_app = db.execute(
            recent_check_sql,
            {
                "cutoff": cutoff_time,
                "p_email": clean_p_email,
                "pro_email": clean_pro_email,
            },
        ).mappings().first()

        if recent_app:
            existing_id = recent_app["application_id"]
            logger.info(
                f"[APPLICATION RECENT DUPLICATE PREVENTED] req_id={req_id} "
                f"matched recent pending application #{existing_id} for email {clean_p_email or clean_pro_email}"
            )
            logger.info(
                f"=== [APPLICATION CREATE REQUEST END] req_id={req_id} "
                f"app_id={existing_id} (DEDUPED RECENT EMAIL) ==="
            )
            return {
                "success": True,
                "application_id": existing_id,
                "message": "Application already submitted and awaiting admin review.",
                "data": {
                    "application_id": existing_id,
                    "approval_status": recent_app["approval_status"],
                    "message": "Application submitted successfully",
                },
            }

    # Validate existing member if member_id was supplied
    clean_member_id = member_id.strip() if member_id else None
    if clean_member_id:
        exists = db.execute(
            text("""
                SELECT member_id
                FROM members
                WHERE UPPER(TRIM(member_id)) = UPPER(:member_id)
            """),
            {"member_id": clean_member_id},
        ).scalar()

        if not exists:
            logger.warning(
                f"[APPLICATION VALIDATION FAILED] req_id={req_id} Existing member ID not found: {clean_member_id}"
            )
            raise HTTPException(
                status_code=400,
                detail="Existing member ID was not found.",
            )

        # Preserve any populated fields from existing member record if omitted in current submission
        existing_profile = db.execute(
            text("""
                SELECT
                    m.academic_title, m.name, m.designation, m.department, m.institution,
                    c.personal_email, c.professional_email, c.mobile, c.whatsapp, c.whatsapp_secondary,
                    c.address, c.city, c.state_province, c.pin_code, c.country,
                    a.date_of_birth, a.qualification, a.research_guideship, a.expertise,
                    a.linkedin, a.orcid, a.google_scholar, a.photo_url
                FROM members m
                LEFT JOIN member_contact_info c ON m.member_id = c.member_id
                LEFT JOIN member_academic_profile a ON m.member_id = a.member_id
                WHERE UPPER(TRIM(m.member_id)) = UPPER(:mid)
            """),
            {"mid": clean_member_id},
        ).mappings().first()

        if existing_profile:
            if not academic_title and existing_profile.get("academic_title"):
                academic_title = existing_profile["academic_title"]
            if not parsed_dob and existing_profile.get("date_of_birth"):
                parsed_dob = existing_profile["date_of_birth"]
            if not highest_qualification and existing_profile.get("qualification"):
                highest_qualification = existing_profile["qualification"]
            if not designation and existing_profile.get("designation"):
                designation = existing_profile["designation"]
            if not department and existing_profile.get("department"):
                department = existing_profile["department"]
            if not institution and existing_profile.get("institution"):
                institution = existing_profile["institution"]
            if not college_address and existing_profile.get("address"):
                college_address = existing_profile["address"]
            if not pin_code and existing_profile.get("pin_code"):
                pin_code = existing_profile["pin_code"]
            if not state_province and existing_profile.get("state_province"):
                state_province = existing_profile["state_province"]
            if not country and existing_profile.get("country"):
                country = existing_profile["country"]
            if not clean_p_email and existing_profile.get("personal_email"):
                clean_p_email = existing_profile["personal_email"]
            if not clean_pro_email and existing_profile.get("professional_email"):
                clean_pro_email = existing_profile["professional_email"]
            if not mobile and existing_profile.get("mobile"):
                mobile = existing_profile["mobile"]
            if not whatsapp and existing_profile.get("whatsapp"):
                whatsapp = existing_profile["whatsapp"]
            if not whatsapp_secondary and existing_profile.get("whatsapp_secondary"):
                whatsapp_secondary = existing_profile["whatsapp_secondary"]
            if not google_scholar and existing_profile.get("google_scholar"):
                google_scholar = existing_profile["google_scholar"]
            if not linkedin and existing_profile.get("linkedin"):
                linkedin = existing_profile["linkedin"]
            if not orcid and existing_profile.get("orcid"):
                orcid = existing_profile["orcid"]
            if not expertise and existing_profile.get("expertise"):
                expertise = existing_profile["expertise"]
            if not research_guideship and existing_profile.get("research_guideship"):
                research_guideship = existing_profile["research_guideship"]

    photo_url = await save_application_photo(photo)
    if clean_member_id and not photo_url:
        existing_photo = db.execute(
            text("SELECT photo_url FROM member_academic_profile WHERE UPPER(TRIM(member_id)) = UPPER(:mid)"),
            {"mid": clean_member_id},
        ).scalar()
        if existing_photo:
            photo_url = existing_photo

    if clean_member_id:
        # Idempotency Check for existing member:
        # Check if there is already a Pending application for this member_id
        pending_existing_app = db.execute(
            select(MembershipApplication).where(
                MembershipApplication.member_id == clean_member_id,
                MembershipApplication.approval_status == "Pending",
            ).order_by(MembershipApplication.application_id.desc())
        ).scalars().first()

        if pending_existing_app:
            existing_id = pending_existing_app.application_id
            logger.info(
                f"[APPLICATION EXISTING MEMBER MATCH] req_id={req_id} "
                f"member_id={clean_member_id} already has pending app_id={existing_id} "
                f"-> updating application snapshot with latest submitted details"
            )
            pending_existing_app.membership_category = membership_category.strip()
            pending_existing_app.full_name = full_name.strip()
            if sub_id_clean:
                pending_existing_app.admin_notes = f"[Submission: {sub_id_clean}]"

            db.execute(
                text("""
                    UPDATE application_applicant_info
                    SET academic_title = :academic_title,
                        date_of_birth = :date_of_birth,
                        highest_qualification = :highest_qualification,
                        designation = :designation,
                        department = :department,
                        institution = :institution,
                        college_address = :college_address,
                        pin_code = :pin_code,
                        state_province = :state_province,
                        country = :country
                    WHERE application_id = :app_id
                """),
                {
                    "academic_title": academic_title,
                    "date_of_birth": parsed_dob,
                    "highest_qualification": highest_qualification,
                    "designation": designation,
                    "department": department,
                    "institution": institution,
                    "college_address": college_address,
                    "pin_code": pin_code,
                    "state_province": state_province,
                    "country": country,
                    "app_id": existing_id,
                },
            )

            db.execute(
                text("""
                    UPDATE application_contact_info
                    SET personal_email = :personal_email,
                        professional_email = :professional_email,
                        mobile = :mobile,
                        whatsapp = :whatsapp,
                        whatsapp_secondary = :whatsapp_secondary,
                        photo_url = :photo_url,
                        google_scholar = :google_scholar,
                        linkedin = :linkedin,
                        orcid = :orcid,
                        expertise = :expertise,
                        research_guideship = :research_guideship
                    WHERE application_id = :app_id
                """),
                {
                    "personal_email": clean_p_email,
                    "professional_email": clean_pro_email,
                    "mobile": mobile,
                    "whatsapp": whatsapp,
                    "whatsapp_secondary": whatsapp_secondary,
                    "photo_url": photo_url,
                    "google_scholar": google_scholar,
                    "linkedin": linkedin,
                    "orcid": orcid,
                    "expertise": expertise,
                    "research_guideship": research_guideship,
                    "app_id": existing_id,
                },
            )
            db.commit()

            logger.info(
                f"=== [APPLICATION CREATE REQUEST END] req_id={req_id} "
                f"app_id={existing_id} (UPDATED PENDING SNAPSHOT) ==="
            )
            return {
                "success": True,
                "application_id": existing_id,
                "message": "Application updated and awaiting review.",
                "data": {
                    "application_id": existing_id,
                    "approval_status": "Pending",
                    "message": "Application updated successfully (idempotent)",
                },
            }

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
                "p_date_of_birth": parsed_dob,
                "p_highest_qualification": highest_qualification,
                "p_designation": designation,
                "p_department": department,
                "p_institution": institution,
                "p_college_address": college_address,
                "p_pin_code": pin_code,
                "p_state_province": state_province,
                "p_country": country,
                "p_personal_email": clean_p_email,
                "p_professional_email": clean_pro_email,
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

        app_id = row["application_id"] if row and "application_id" in row else None

        # Tag with submission_id in admin_notes if provided
        if app_id and sub_id_clean:
            app_record = db.get(MembershipApplication, app_id)
            if app_record:
                curr_notes = app_record.admin_notes or ""
                app_record.admin_notes = f"{curr_notes}\n[Submission: {sub_id_clean}]".strip()
                db.commit()

        logger.info(
            f"=== [APPLICATION CREATE REQUEST END] req_id={req_id} app_id={app_id} (NEW CREATED) ==="
        )

        return {
            "success": True,
            "application_id": app_id,
            "message": "Application submitted successfully and is awaiting admin review.",
            "data": dict(row) if row else None,
        }

    except Exception as exc:
        db.rollback()
        logger.error(f"[APPLICATION CREATE ERROR] req_id={req_id} error={str(exc)}")
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