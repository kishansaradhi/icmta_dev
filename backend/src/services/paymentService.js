const FEE_MAP = {
  "life member (faculty)": 5000,
  "life membership (faculty)": 5000,
  "annual member (faculty)": 1000,
  "annual membership (faculty)": 1000,
  "research scholar member": 600,
  "research scholar membership": 600,
  "institutional (university / b-school)": 25000,
  "institutional (college / institute)": 12000,
};

function calculateMembershipFee(category) {
  if (!category) throw new Error("Membership category is required to determine fee.");

  const c = String(category).trim().toLowerCase();
  if (FEE_MAP[c] !== undefined) return FEE_MAP[c];
  if (c.includes("life")) return 5000;
  if (c.includes("annual")) return 1000;
  if (c.includes("research scholar")) return 600;
  if (c.includes("university") || c.includes("b-school")) return 25000;
  if (c.includes("college") || c.includes("institute")) return 12000;

  throw new Error(`Unsupported membership category: '${category}'`);
}

module.exports = { calculateMembershipFee };
