function cleanString(value) {
  if (value === undefined || value === null) return null;
  const v = String(value).trim();
  return v ? v : null;
}

function cleanEmail(value) {
  const v = cleanString(value);
  return v ? v.toLowerCase() : null;
}

function parseDate(value) {
  const v = cleanString(value);
  if (!v) return null;

  if (/^\d{4}-\d{2}-\d{2}$/.test(v)) return v;

  const m = v.match(/^(\d{2})\/(\d{2})\/(\d{4})$/);
  if (m) return `${m[3]}-${m[2]}-${m[1]}`;

  return null;
}

function isFutureDate(dateString) {
  if (!dateString) return false;
  const d = new Date(`${dateString}T00:00:00`);
  const now = new Date();
  now.setHours(0, 0, 0, 0);
  return d > now;
}

function parseJsonBody(req) {
  return req.body && typeof req.body === "object" ? req.body : {};
}

module.exports = {
  cleanString,
  cleanEmail,
  parseDate,
  isFutureDate,
  parseJsonBody,
};
