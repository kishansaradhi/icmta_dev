function errorHandler(err, req, res, next) {
  console.error(`[ERROR] ${req.method} ${req.originalUrl}`, err);

  if (err && err.code === "LIMIT_FILE_SIZE") {
    return res.status(400).json({ detail: "Uploaded file is too large." });
  }

  if (err && err.code === "ER_DUP_ENTRY") {
    return res.status(409).json({ detail: "Duplicate value violates a database constraint." });
  }

  const status = Number(err.statusCode || err.status || 500);
  return res.status(status >= 400 && status < 600 ? status : 500).json({
    detail: err.message || "Internal server error",
  });
}

module.exports = { errorHandler };
