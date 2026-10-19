const { query, getConnection } = require("../db/pool");

async function nextMemberId(connection = null) {
  const conn = connection || await getConnection();
  let release = false;
  if (!connection) release = true;

  try {
    const [lockRows] = await conn.query("SELECT GET_LOCK(?, 10) AS acquired", [
      "icmt_member_id_generation",
    ]);
    if (lockRows[0]?.acquired !== 1) {
      throw new Error("Could not acquire member ID generation lock");
    }

    const [rows] = await conn.query(
      "SELECT member_id FROM members WHERE member_id IS NOT NULL"
    );

    let maxNumber = 0;
    let prefix = "ICMT";
    for (const row of rows) {
      const m = String(row.member_id || "").match(/^([A-Za-z]+)(\d+)$/);
      if (m) {
        const n = Number(m[2]);
        if (n > maxNumber) {
          maxNumber = n;
          prefix = m[1].toUpperCase();
        }
      }
    }

    return `${prefix}${String(maxNumber + 1).padStart(3, "0")}`;
  } finally {
    try {
      await conn.query("SELECT RELEASE_LOCK(?)", ["icmt_member_id_generation"]);
    } finally {
      if (release) conn.release();
    }
  }
}

async function findMember(memberId) {
  const rows = await query(
    "SELECT member_id, name, designation, department, institution FROM members WHERE UPPER(TRIM(member_id)) = UPPER(TRIM(?)) LIMIT 1",
    [memberId]
  );
  return rows[0] || null;
}

module.exports = { nextMemberId, findMember };
