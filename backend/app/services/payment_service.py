
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.models.membership_application import MembershipApplication
from app.models.membership_payment import MembershipPayment


def validate_payment_reference(
    db: Session,
    transaction_id: str | None,
    application_id: int | None,
):
    if transaction_id:
        existing = db.execute(
            select(MembershipPayment).where(
                MembershipPayment.transaction_id == transaction_id
            )
        ).scalar_one_or_none()
        if existing:
            raise ValueError("Transaction already exists.")

    if application_id:
        application = db.get(MembershipApplication, application_id)
        if not application:
            raise ValueError("Application does not exist.")


MEMBERSHIP_FEE_MAP: dict[str, float] = {
    "life member (faculty)": 5000.0,
    "life membership (faculty)": 5000.0,
    "annual member (faculty)": 1000.0,
    "annual membership (faculty)": 1000.0,
    "research scholar member": 600.0,
    "research scholar membership": 600.0,
    "institutional (university / b-school)": 25000.0,
    "institutional (college / institute)": 12000.0,
}


def calculate_membership_fee(category: str | None) -> float:
    """Determine the canonical fee for a membership category server-side."""
    if not category:
        raise ValueError("Membership category is required to determine fee.")

    cat_norm = category.strip().lower()
    if cat_norm in MEMBERSHIP_FEE_MAP:
        return MEMBERSHIP_FEE_MAP[cat_norm]

    # Keyword fallback matching
    if "life" in cat_norm:
        return 5000.0
    if "annual" in cat_norm:
        return 1000.0
    if "research scholar" in cat_norm:
        return 600.0
    if "university" in cat_norm or "b-school" in cat_norm:
        return 25000.0
    if "college" in cat_norm or "institute" in cat_norm:
        return 12000.0

    raise ValueError(f"Unsupported membership category: '{category}'")

