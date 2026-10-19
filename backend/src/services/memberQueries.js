const MEMBER_SELECT = `
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
  LEFT JOIN member_contact_info c ON m.member_id = c.member_id
  LEFT JOIN member_academic_profile a ON m.member_id = a.member_id
`;

async function getMemberById(queryFn, memberId, activeOnly = true) {
  const sql = `${MEMBER_SELECT}
    WHERE UPPER(TRIM(m.member_id)) = UPPER(TRIM(?))
    ${activeOnly ? "AND m.is_active = TRUE AND m.my_status = 'Active'" : ""}
    LIMIT 1`;
  const rows = await queryFn(sql, [memberId]);
  return rows[0] || null;
}

module.exports = { MEMBER_SELECT, getMemberById };
