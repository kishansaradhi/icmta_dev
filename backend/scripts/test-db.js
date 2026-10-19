const { testConnection } = require("../src/db/pool");

(async () => {
  try {
    const ok = await testConnection();
    console.log(ok ? "MySQL connection OK" : "MySQL connection failed");
    process.exit(ok ? 0 : 1);
  } catch (err) {
    console.error("MySQL connection failed:", err.message);
    process.exit(1);
  }
})();
