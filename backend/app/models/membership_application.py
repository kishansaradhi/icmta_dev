
from datetime import date, datetime
from sqlalchemy import BigInteger, Date, DateTime, Enum, ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from app.core.database import Base


class MembershipApplication(Base):
    __tablename__ = "membership_applications"

    application_id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    member_id: Mapped[str | None] = mapped_column(String(20), nullable=True)
    membership_category: Mapped[str] = mapped_column(String(100), nullable=False)
    full_name: Mapped[str] = mapped_column(String(200), nullable=False)
    approval_status: Mapped[str] = mapped_column(
        Enum("Pending", "Approved", "Rejected", name="application_status"),
        nullable=False,
        default="Pending",
    )
    admin_notes: Mapped[str | None] = mapped_column(Text)
    reviewed_by: Mapped[int | None] = mapped_column(
        BigInteger,
        ForeignKey("admin_users.admin_id", onupdate="CASCADE", ondelete="SET NULL"),
    )
    reviewed_at: Mapped[datetime | None] = mapped_column(DateTime)
    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False)
    updated_at: Mapped[datetime] = mapped_column(DateTime, nullable=False)

