from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy import text
from sqlalchemy.orm import Session

from app.core.database import get_db

router = APIRouter(tags=["Members"])


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

        WHERE m.is_active = TRUE
          AND m.my_status = 'Active'

          AND (
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

        WHERE m.member_id = :member_id
          AND m.is_active = TRUE
          AND m.my_status = 'Active'
    """)

    result = db.execute(
        sql,
        {"member_id": member_id},
    ).mappings().first()

    if not result:
        raise HTTPException(
            status_code=404,
            detail="Member not found",
        )

    return {
        "success": True,
        "data": dict(result),
    }