const mysql = require("mysql2/promise");
const config = require("../config/env");

if (!config.db.host || !config.db.user || !config.db.database) {
  console.warn("[DB] DB_HOST, DB_USER and DB_NAME must be configured in .env");
}

const pool = mysql.createPool({
  host: config.db.host,
  port: config.db.port,
  user: config.db.user,
  password: config.db.password,
  database: config.db.database,
  waitForConnections: true,
  connectionLimit: Number(process.env.DB_CONNECTION_LIMIT || 10),
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 10000,
  timezone: "local",
  decimalNumbers: true,
  charset: "utf8mb4",
});

async function query(sql, params = []) {
  const [rows] = await pool.execute(sql, params);
  return rows;
}

async function getConnection() {
  return pool.getConnection();
}

async function testConnection() {
  const [rows] = await pool.query("SELECT 1 AS ok");
  return rows[0]?.ok === 1;
}

module.exports = { pool, query, getConnection, testConnection };
