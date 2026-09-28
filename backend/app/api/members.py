from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel
from sqlalchemy import text
from sqlalchemy.orm import Session

from app.core.database import get_db

router = APIRouter(tags=["Members"])


class MemberVerifyRequest(BaseModel):
    member_id: str
    email: str


@router.get("/members", response_model=dict)
def list_members(
    q: str | None = Query(default=None),
    state: str | None = Query(default=None),
    department: str | None = Query(default=None),
    db: Session = Depends(get_db),
):
    search = f"%{q.strip()}%" if q and q.strip() else None

    sql = text("""
        SELECT
            m.member_id,
            m.academic_title,
            m.name,
            a.date_of_birth,
            a.qualification,
            m.designation,
            m.department,
            m.institution,

            c.address,
            c.city,
            c.state_province,
            c.pin_code,
            c.country,

            a.research_guideship,
            a.expertise,

            c.mobile,
            c.whatsapp,
            c.whatsapp_secondary,
            c.professional_email,
            c.personal_email,

            a.linkedin,
            a.orcid,
            a.google_scholar,
            a.photo_url,

            m.membership_category,
            m.is_active,
            a.source_record,
            m.my_status,
            m.created_at,
            m.updated_at

        FROM members m

        LEFT JOIN member_contact_info c
            ON m.member_id = c.member_id

        LEFT JOIN member_academic_profile a
            ON m.member_id = a.member_id

        WHERE (
              :search IS NULL
              OR m.name LIKE :search
              OR m.member_id LIKE :search
              OR m.institution LIKE :search
              OR m.designation LIKE :search
              OR m.department LIKE :search
              OR a.expertise LIKE :search
          )

          AND (
              :state IS NULL
              OR c.state_province = :state
          )

          AND (
              :department IS NULL
              OR m.department = :department
          )

        ORDER BY m.member_id ASC
    """)

    result = db.execute(
        sql,
        {
            "search": search,
            "state": state,
            "department": department,
        },
    )

    members = [dict(row) for row in result.mappings().all()]

    return {
        "success": True,
        "data": members,
        "count": len(members),
    }


@router.get("/members/{member_id}", response_model=dict)
def get_member(
    member_id: str,
    db: Session = Depends(get_db),
):
    sql = text("""
        SELECT
            m.member_id,
            m.academic_title,
            m.name,
            a.date_of_birth,
            a.qualification,
            m.designation,
            m.department,
            m.institution,

            c.address,
            c.city,
            c.state_province,
            c.pin_code,
            c.country,

            a.research_guideship,
            a.expertise,

            c.mobile,
            c.whatsapp,
            c.whatsapp_secondary,
            c.professional_email,
            c.personal_email,

            a.linkedin,
            a.orcid,
            a.google_scholar,
            a.photo_url,

            m.membership_category,
            m.is_active,
            a.source_record,
            m.my_status,
            m.created_at,
            m.updated_at

        FROM members m

        LEFT JOIN member_contact_info c
            ON m.member_id = c.member_id

        LEFT JOIN member_academic_profile a
            ON m.member_id = a.member_id

        WHERE UPPER(TRIM(m.member_id)) = UPPER(TRIM(:member_id))
          AND m.is_active = TRUE
          AND m.my_status = 'Active'
    """)

    clean_id = member_id.strip()
    result = db.execute(
        sql,
        {"member_id": clean_id},
    ).mappings().first()

    if not result:
        raise HTTPException(
            status_code=404,
            detail="Member not found or inactive.",
        )

    return {
        "success": True,
        "data": dict(result),
    }


@router.post("/members/verify", response_model=dict)
def verify_member(
    payload: MemberVerifyRequest,
    db: Session = Depends(get_db),
):
    member_id = payload.member_id.strip()
    email = payload.email.strip().lower()

    if not member_id or not email:
        raise HTTPException(
            status_code=400,
            detail="Member ID and registered email are required.",
        )

    sql = text("""
        SELECT
            m.member_id,
            m.academic_title,
            m.name,
            m.designation,
            m.department,
            m.institution,
            m.membership_category,
            m.is_active,
            m.my_status,
            c.personal_email,
            c.professional_email,
            c.mobile,
            c.whatsapp,
            c.whatsapp_secondary,
            c.address,
            c.city,
            c.state_province,
            c.pin_code,
            c.country,
            a.date_of_birth,
            a.qualification,
            a.research_guideship,
            a.expertise,
            a.linkedin,
            a.orcid,
            a.google_scholar,
            a.photo_url
        FROM members m
        LEFT JOIN member_contact_info c
            ON m.member_id = c.member_id
        LEFT JOIN member_academic_profile a
            ON m.member_id = a.member_id
        WHERE UPPER(TRIM(m.member_id)) = UPPER(:member_id)
          AND (
              (c.personal_email IS NOT NULL AND LOWER(TRIM(c.personal_email)) = :email)
              OR (c.professional_email IS NOT NULL AND LOWER(TRIM(c.professional_email)) = :email)
          )
        LIMIT 1
    """)

    result = db.execute(sql, {"member_id": member_id, "email": email}).mappings().first()

    if not result:
        raise HTTPException(
            status_code=404,
            detail="Member not found. Please check your Member ID and registered email.",
        )

    row = dict(result)
    matched_email = email
    if row.get("professional_email") and row["professional_email"].lower() == email:
        matched_email = row["professional_email"]
    elif row.get("personal_email") and row["personal_email"].lower() == email:
        matched_email = row["personal_email"]

    return {
        "success": True,
        "message": "Member verified successfully.",
        "data": {
            "member_id": row["member_id"],
            "academic_title": row["academic_title"],
            "name": row["name"],
            "designation": row["designation"],
            "department": row["department"],
            "institution": row["institution"],
            "current_membership_category": row["membership_category"],
            "registered_email": matched_email,
            "personal_email": row["personal_email"],
            "professional_email": row["professional_email"],
            "mobile": row["mobile"],
            "whatsapp": row["whatsapp"],
            "whatsapp_secondary": row["whatsapp_secondary"],
            "address": row["address"],
            "city": row["city"],
            "state_province": row["state_province"],
            "pin_code": row["pin_code"],
            "country": row["country"] or "India",
            "date_of_birth": str(row["date_of_birth"]) if row["date_of_birth"] else None,
            "qualification": row["qualification"],
            "research_guideship": row["research_guideship"],
            "expertise": row["expertise"],
            "google_scholar": row["google_scholar"],
            "linkedin": row["linkedin"],
            "orcid": row["orcid"],
            "photo_url": row["photo_url"],
        },
    }