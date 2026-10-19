# ICMTA Node.js + Express + Frontend — Hostinger Deployment

This package is prepared to run the ICMTA frontend and Node.js/Express backend
as one Hostinger Node.js application.

## Project layout

- Frontend: project root (`index.html`, `css/`, `js/`, `pages/`, `images/`, etc.)
- Backend: `backend/src/`
- Node entry point: `backend/src/server.js`
- Start command: `node backend/src/server.js`
- API prefix: `/api`
- Health check: `/api/health`
- Uploads: root `uploads/`

## Hostinger environment variables

Create these in Hostinger; do not commit a real `.env` file:

DB_HOST=srv876.hstgr.io
DB_PORT=3306
DB_USER=u594628539_icmta_user
DB_PASSWORD=<your current database password>
DB_NAME=u594628539_icmta_qa
JWT_SECRET=<new random secret>
JWT_EXPIRE_MINUTES=480
CORS_ORIGINS=https://qa.icmta.net
PUBLIC_API_URL=https://qa.icmta.net
UPLOAD_DIR=uploads

## Important

- `node_modules` is intentionally excluded. Hostinger should run npm install/build as configured.
- The real `.env` is intentionally excluded.
- The frontend uses same-origin API requests, so production requests go to `https://qa.icmta.net/api/...`.
