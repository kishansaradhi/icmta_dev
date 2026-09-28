/* ==========================================================================
   ICMTA Admin Portal — Membership Applications & Approval Module
   ========================================================================== */

let _currentReviewAppId = null;
let _cachedAdminApps = [];

function escHtml(str) {
  if (str === null || str === undefined) return '';
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function fmtAppDate(isoStr) {
  if (!isoStr) return '—';
  try {
    const d = new Date(isoStr);
    return d.toLocaleDateString('en-IN', {
      day: '2-digit',
      month: 'short',
      year: 'numeric'
    });
  } catch (e) {
    return isoStr;
  }
}

function fmtAppDateTime(isoStr) {
  if (!isoStr) return '—';
  try {
    const d = new Date(isoStr);
    return d.toLocaleString('en-IN', {
      dateStyle: 'medium',
      timeStyle: 'short'
    });
  } catch (e) {
    return isoStr;
  }
}

function getAppStatusBadge(status) {
  const s = String(status || 'Pending').trim();
  if (s === 'Approved') {
    return '<span class="badge" style="background:#ecfdf5;color:#065f46;border:1px solid #a7f3d0;font-weight:700;">✓ Approved</span>';
  } else if (s === 'Rejected') {
    return '<span class="badge" style="background:#fef2f2;color:#991b1b;border:1px solid #fecaca;font-weight:700;">✕ Rejected</span>';
  }
  return '<span class="badge" style="background:#fffbeb;color:#92400e;border:1px solid #fef3c7;font-weight:700;">⏳ Pending</span>';
}

function getPaymentStatusBadge(status) {
  const s = String(status || 'Not Submitted').trim();
  if (s === 'Paid') {
    return '<span class="badge" style="background:#ecfdf5;color:#065f46;border:1px solid #a7f3d0;font-weight:700;">✓ Paid / Verified</span>';
  } else if (s === 'Pending') {
    return '<span class="badge" style="background:#fffbeb;color:#92400e;border:1px solid #fef3c7;font-weight:700;">⏳ Pending</span>';
  } else if (s === 'Failed') {
    return '<span class="badge" style="background:#fef2f2;color:#991b1b;border:1px solid #fecaca;font-weight:700;">✕ Failed</span>';
  }
  return '<span class="badge" style="background:#f1f5f9;color:#64748b;border:1px solid #e2e8f0;font-weight:600;">Not Submitted</span>';
}

function getMemberTypeBadge(type, memberId) {
  if (type === 'Existing Member' || memberId) {
    return `<span class="badge" style="background:#eff6ff;color:#1d4ed8;border:1px solid #bfdbfe;font-weight:700;">🔒 Existing (${escHtml(memberId || '')})</span>`;
  }
  return '<span class="badge" style="background:#f5f3ff;color:#6d28d9;border:1px solid #ddd6fe;font-weight:700;">New Member</span>';
}

async function updateAdminApplicationCounters() {
  try {
    const metrics = await getAdminMetrics();
    if (metrics) {
      const pCount = metrics.pending_applications || 0;
      const elDash = document.getElementById('metricPendingApplications');
      if (elDash) elDash.textContent = pCount;
      const elNav = document.getElementById('navPendingAppsBadge');
      if (elNav) {
        elNav.textContent = pCount;
        elNav.style.display = pCount > 0 ? 'inline-block' : 'none';
      }
      const elHeader = document.getElementById('appHeaderPendingBadge');
      if (elHeader) {
        elHeader.textContent = pCount + ' Pending';
      }
    }
  } catch (e) {
    console.warn('Could not update admin metrics:', e);
  }
}

async function loadAdminApplications() {
  const tbody = document.getElementById('applicationsTableBody');
  const emptyMsg = document.getElementById('applicationsEmptyMessage');
  if (!tbody) return;

  const status = document.getElementById('appFilterStatus')?.value || 'All';
  const memberType = document.getElementById('appFilterMemberType')?.value || 'All';
  const payment = document.getElementById('appFilterPayment')?.value || 'All';

  tbody.innerHTML = '<tr><td colspan="9" style="text-align:center;padding:24px;color:#64748b;">Loading applications...</td></tr>';
  if (emptyMsg) emptyMsg.style.display = 'none';

  try {
    const apps = await getAdminApplications(status, memberType, payment);
    _cachedAdminApps = Array.isArray(apps) ? apps : [];
    renderApplicationsTable(_cachedAdminApps);
    updateAdminApplicationCounters();
  } catch (err) {
    console.error('Error loading applications:', err);
    tbody.innerHTML = `<tr><td colspan="9" style="text-align:center;padding:24px;color:#dc2626;">Failed to load applications: ${escHtml(err.message || 'Server error')}</td></tr>`;
  }
}

function filterAdminApplicationsLocal() {
  const searchInput = document.getElementById('appSearchInput');
  const q = (searchInput?.value || '').trim().toLowerCase();

  if (!q) {
    renderApplicationsTable(_cachedAdminApps);
    return;
  }

  const filtered = _cachedAdminApps.filter(app => {
    const appId = String(app.application_id || '');
    const formattedAppId = 'apl' + appId.padStart(6, '0');
    const memberId = (app.member_id || '').toLowerCase();
    const name = (app.full_name || '').toLowerCase();
    const email = (app.professional_email || app.personal_email || '').toLowerCase();
    const txn = (app.transaction_id || '').toLowerCase();

    return appId.includes(q) ||
           formattedAppId.includes(q) ||
           memberId.includes(q) ||
           name.includes(q) ||
           email.includes(q) ||
           txn.includes(q);
  });

  renderApplicationsTable(filtered);
}

function renderApplicationsTable(apps) {
  const tbody = document.getElementById('applicationsTableBody');
  const emptyMsg = document.getElementById('applicationsEmptyMessage');
  const tableWrap = tbody?.closest('.table-wrap');
  if (!tbody) return;

  tbody.innerHTML = '';

  if (!apps || apps.length === 0) {
    if (tableWrap) tableWrap.style.display = 'none';
    if (emptyMsg) emptyMsg.style.display = 'block';
    return;
  }

  if (tableWrap) tableWrap.style.display = '';
  if (emptyMsg) emptyMsg.style.display = 'none';

  apps.forEach(app => {
    const tr = document.createElement('tr');
    const formattedAppId = 'APL' + String(app.application_id).padStart(6, '0');

    const memberIdCell = (app.approval_status === 'Approved' && app.member_id)
      ? `<a href="member-profile.html?id=${encodeURIComponent(app.member_id)}" target="_blank" title="View Public Profile" style="color:#0284c7;text-decoration:underline;">${escHtml(app.member_id)} ↗</a>`
      : (app.member_id ? escHtml(app.member_id) : '<span style="color:#94a3b8;">—</span>');

    tr.innerHTML = `
      <td style="font-family:monospace;font-weight:700;color:var(--navy);font-size:13px;">${escHtml(formattedAppId)} <span style="font-size:11px;color:#94a3b8;">(#${app.application_id})</span></td>
      <td style="font-family:monospace;font-weight:700;color:#0284c7;">${memberIdCell}</td>
      <td style="font-weight:700;color:#0f172a;">${escHtml(app.full_name || '—')}</td>
      <td>${getMemberTypeBadge(app.member_type, app.member_id)}</td>
      <td style="font-size:12.5px;color:#334155;">${escHtml(app.membership_category || '—')}</td>
      <td>${getAppStatusBadge(app.approval_status)}</td>
      <td>${getPaymentStatusBadge(app.payment_status)}</td>
      <td style="font-size:12px;color:#64748b;">${fmtAppDate(app.created_at)}</td>
      <td>
        <button class="btn secondary" type="button" style="padding:5px 12px;font-size:12px;font-weight:700;" onclick="reviewApplication(${app.application_id})">
          Review &rarr;
        </button>
      </td>
    `;
    tbody.appendChild(tr);
  });
}

async function reviewApplication(applicationId) {
  _currentReviewAppId = applicationId;
  const panel = document.getElementById('appReviewPanel');
  const container = document.getElementById('appReviewDetailsContainer');
  if (!panel || !container) return;

  panel.style.display = 'block';
  panel.scrollIntoView({ behavior: 'smooth', block: 'start' });

  container.innerHTML = `
    <div style="padding:32px;text-align:center;color:#64748b;">
      <div>Loading application details for #${applicationId}...</div>
    </div>
  `;

  try {
    const res = await getAdminApplicationDetail(applicationId);
    renderReviewDetailView(res);
  } catch (err) {
    console.error('Failed to load detail:', err);
    container.innerHTML = `
      <div style="padding:24px;background:#fef2f2;border:1px solid #fecaca;border-radius:8px;color:#dc2626;">
        Failed to load application details: ${escHtml(err.message || 'Server error')}
      </div>
    `;
  }
}

function closeApplicationReview() {
  const panel = document.getElementById('appReviewPanel');
  if (panel) panel.style.display = 'none';
  _currentReviewAppId = null;
}

function renderReviewDetailView(data) {
  const container = document.getElementById('appReviewDetailsContainer');
  if (!container) return;

  const formattedAppId = 'APL' + String(data.application_id).padStart(6, '0');
  const isPending = data.approval_status === 'Pending';
  const isApproved = data.approval_status === 'Approved';
  const isPaymentPending = data.payment_status === 'Pending';

  const photoHtml = data.photo_url
    ? `<img src="${escHtml(data.photo_url)}" alt="Applicant Photo" style="width:120px;height:140px;object-fit:cover;border-radius:8px;border:1px solid #cbd5e1;box-shadow:0 4px 10px rgba(0,0,0,0.08);"> <div style="margin-top:6px;font-size:11px;color:#64748b;text-align:center;">Photo Preview</div>`
    : `<div style="width:120px;height:140px;background:#f1f5f9;border:1px dashed #cbd5e1;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#94a3b8;font-size:12px;text-align:center;padding:8px;">No photo uploaded</div>`;

  const proofBtnHtml = data.payment_proof
    ? `<button type="button" class="btn secondary" style="font-size:12.5px;padding:6px 12px;display:inline-flex;align-items:center;gap:6px;" onclick="viewPaymentProof(${data.application_id}, '${escHtml(data.payment_proof)}')">
        <span>📄</span> View Payment Proof
       </button>`
    : `<span style="font-size:12px;color:#94a3b8;font-style:italic;">No proof attached</span>`;

  let paymentActionsHtml = '';
  if (data.payment_id && isPaymentPending && !isApproved) {
    paymentActionsHtml = `
      <div style="margin-top:14px;padding:12px 14px;background:#fefce8;border:1px solid #fef08a;border-radius:8px;display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap;">
        <div style="font-size:13px;color:#854d0e;">
          <strong>Action Required:</strong> Verify manual transaction ID / UTR before approving application.
        </div>
        <div style="display:flex;gap:8px;">
          <button type="button" id="btnVerifyPayInReview" class="btn primary" style="background:#16a34a;border-color:#16a34a;padding:7px 14px;font-size:13px;" onclick="verifyPaymentInReview(${data.payment_id})">
            ✓ Verify Payment (Mark as Paid)
          </button>
          <button type="button" id="btnRejectPayInReview" class="btn" style="background:#ef4444;border-color:#ef4444;color:#fff;padding:7px 14px;font-size:13px;" onclick="rejectPaymentInReview(${data.payment_id})">
            ✕ Mark as Failed
          </button>
        </div>
      </div>
    `;
  }

  let finalDecisionHtml = '';
  if (isPending) {
    finalDecisionHtml = `
      <div style="display:flex;justify-content:flex-end;gap:12px;padding:18px;background:#f8fafc;border-top:1px solid #e2e8f0;border-radius:0 0 10px 10px;">
        <button type="button" id="btnRejectApp" class="btn" style="background:#dc2626;border-color:#dc2626;color:#ffffff;padding:10px 22px;font-size:14px;font-weight:700;" onclick="rejectApplicationPrompt(${data.application_id}, '${escHtml(data.full_name)}')">
          ✕ Reject Application
        </button>
        <button type="button" id="btnApproveApp" class="btn primary" style="background:#16a34a;border-color:#16a34a;padding:10px 24px;font-size:14px;font-weight:700;" onclick="approveApplicationPrompt(${data.application_id}, '${escHtml(data.full_name)}', '${escHtml(data.member_id || '')}', '${escHtml(data.payment_status)}')">
          ✓ Approve Membership Application
        </button>
      </div>
    `;
  } else if (isApproved) {
    finalDecisionHtml = `
      <div style="padding:16px 20px;background:#f0fdf4;border-top:1px solid #bbf7d0;border-radius:0 0 10px 10px;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:10px;">
        <div style="font-size:14px;color:#166534;font-weight:700;">
          ✓ This membership application was Approved on ${fmtAppDateTime(data.reviewed_at)}.
          ${data.member_id ? `Active Member ID: <span style="font-family:monospace;color:#0284c7;">${escHtml(data.member_id)}</span>` : ''}
        </div>
        <div style="display:flex;align-items:center;gap:10px;">
          ${data.member_id ? `<a href="member-profile.html?id=${encodeURIComponent(data.member_id)}" target="_blank" class="btn" style="background:#0284c7;border-color:#0284c7;color:#fff;padding:6px 14px;font-size:12.5px;font-weight:700;text-decoration:none;">View Public Profile &rarr;</a>` : ''}
          <span class="badge" style="background:#16a34a;color:#fff;padding:6px 14px;font-size:12px;font-weight:700;">Approved</span>
        </div>
      </div>
    `;
  } else {
    finalDecisionHtml = `
      <div style="padding:16px 20px;background:#fef2f2;border-top:1px solid #fecaca;border-radius:0 0 10px 10px;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:10px;">
        <div style="font-size:14px;color:#991b1b;font-weight:700;">
          ✕ This application was Rejected on ${fmtAppDateTime(data.reviewed_at)}.
          ${data.admin_notes ? `<div style="font-size:13px;font-weight:normal;margin-top:4px;">Reason: ${escHtml(data.admin_notes)}</div>` : ''}
        </div>
        <span class="badge" style="background:#dc2626;color:#fff;padding:6px 14px;font-size:12px;font-weight:700;">Rejected</span>
      </div>
    `;
  }

  container.innerHTML = `
    <div style="background:#ffffff;border:1px solid #e2e8f0;border-radius:10px;overflow:hidden;box-shadow:0 4px 18px rgba(0,0,0,0.03);">

      <!-- Top Summary Header -->
      <div style="padding:18px 22px;background:#f8fafc;border-bottom:1px solid #e2e8f0;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:12px;">
        <div>
          <span style="font-size:11px;font-weight:700;color:#64748b;text-transform:uppercase;letter-spacing:.05em;">Application Summary</span>
          <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
            <span style="font-family:monospace;font-size:18px;font-weight:800;color:var(--navy);">${escHtml(formattedAppId)}</span>
            ${getMemberTypeBadge(data.member_type, data.member_id)}
            ${getAppStatusBadge(data.approval_status)}
            ${getPaymentStatusBadge(data.payment_status)}
          </div>
        </div>
        <div style="text-align:right;font-size:12.5px;color:#64748b;">
          <div>Submitted: <strong>${fmtAppDateTime(data.created_at)}</strong></div>
          ${data.reviewed_at ? `<div>Reviewed: <strong>${fmtAppDateTime(data.reviewed_at)}</strong></div>` : ''}
        </div>
      </div>

      <!-- Main Review Body -->
      <div style="padding:22px;display:flex;flex-direction:column;gap:24px;">

        <!-- 1. MEMBER PROFILE & CREDENTIALS -->
        <div>
          <h4 style="margin:0 0 12px 0;font-size:15px;color:var(--navy);border-bottom:2px solid #e2e8f0;padding-bottom:6px;">
            1. Applicant & Member Profile
          </h4>
          <div style="display:flex;gap:22px;flex-wrap:wrap;">
            <div style="flex-shrink:0;">
              ${photoHtml}
            </div>
            <div style="flex:1;min-width:280px;display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:12px 20px;">
              ${fieldItem('Full Name', `${data.academic_title ? data.academic_title + ' ' : ''}${data.full_name || '—'}`)}
              ${fieldItem('Member ID', data.member_id ? `<span style="font-family:monospace;font-weight:700;color:#0284c7;">${escHtml(data.member_id)} 🔒 (Existing)</span>` : '<span style="color:#64748b;">New Member (Will be generated)</span>')}
              ${fieldItem('Category', data.membership_category || '—')}
              ${fieldItem('Date of Birth', data.date_of_birth || '—')}
              ${fieldItem('Qualification', data.highest_qualification || '—')}
              ${fieldItem('Designation', data.designation || '—')}
              ${fieldItem('Department', data.department || '—')}
              ${fieldItem('Institution', data.institution || '—')}
              ${fieldItem('College Address', data.college_address || '—')}
              ${fieldItem('State / Province', data.state_province || '—')}
              ${fieldItem('PIN Code', data.pin_code || '—')}
              ${fieldItem('Country', data.country || 'India')}
            </div>
          </div>
        </div>

        <!-- 2. CONTACT & RESEARCH DETAILS -->
        <div>
          <h4 style="margin:0 0 12px 0;font-size:15px;color:var(--navy);border-bottom:2px solid #e2e8f0;padding-bottom:6px;">
            2. Contact & Research Links
          </h4>
          <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:12px 20px;">
            ${fieldItem('Personal Email', data.personal_email ? `<a href="mailto:${escHtml(data.personal_email)}" style="color:var(--blue);">${escHtml(data.personal_email)}</a>` : '—')}
            ${fieldItem('Professional Email', data.professional_email ? `<a href="mailto:${escHtml(data.professional_email)}" style="color:var(--blue);">${escHtml(data.professional_email)}</a>` : '—')}
            ${fieldItem('Mobile Number', data.mobile ? `<a href="tel:${escHtml(data.mobile)}" style="color:#0f172a;">${escHtml(data.mobile)}</a>` : '—')}
            ${fieldItem('WhatsApp', data.whatsapp || '—')}
            ${fieldItem('Secondary WhatsApp', data.whatsapp_secondary || '—')}
            ${fieldItem('Research Guideship', data.research_guideship || '—')}
            ${fieldItem('Expertise', data.expertise || '—')}
            ${fieldItem('Google Scholar', data.google_scholar ? `<a href="${escHtml(data.google_scholar)}" target="_blank" style="color:var(--blue);">Open Profile &rarr;</a>` : '—')}
            ${fieldItem('LinkedIn', data.linkedin ? `<a href="${escHtml(data.linkedin)}" target="_blank" style="color:var(--blue);">Open Profile &rarr;</a>` : '—')}
            ${fieldItem('ORCID', data.orcid || '—')}
          </div>
        </div>

        <!-- 3. PAYMENT SECTION -->
        <div style="background:#f8fafc;border:1px solid #e2e8f0;border-radius:8px;padding:18px;">
          <h4 style="margin:0 0 12px 0;font-size:15px;color:#5f259f;display:flex;align-items:center;gap:8px;">
            <span>💳</span> 3. Payment Details & Verification
          </h4>
          <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:12px 20px;">
            ${fieldItem('Amount Payable', data.amount !== null ? `₹ ${Number(data.amount).toLocaleString('en-IN')}` : '—')}
            ${fieldItem('Currency', data.currency || 'INR')}
            ${fieldItem('Payment Method', data.payment_method || 'PhonePe QR / Manual Transfer')}
            ${fieldItem('Payment Gateway', data.payment_gateway || 'Manual Verification')}
            ${fieldItem('Transaction ID / UTR', data.transaction_id ? `<span style="font-family:monospace;font-weight:700;color:#0f172a;background:#fff;padding:2px 8px;border:1px solid #cbd5e1;border-radius:4px;">${escHtml(data.transaction_id)}</span>` : '—')}
            ${fieldItem('Payment Status', getPaymentStatusBadge(data.payment_status))}
            ${fieldItem('Paid / Verified At', data.paid_at ? fmtAppDateTime(data.paid_at) : '—')}
            ${fieldItem('Payment Proof', proofBtnHtml)}
          </div>
          ${paymentActionsHtml}
        </div>

        ${data.admin_notes ? `
          <div style="padding:12px 14px;background:#f1f5f9;border-left:4px solid #64748b;border-radius:6px;font-size:13px;color:#334155;">
            <strong>Admin Notes:</strong> ${escHtml(data.admin_notes)}
          </div>
        ` : ''}

      </div>

      <!-- Bottom Action Bar -->
      ${finalDecisionHtml}

    </div>
  `;
}

function fieldItem(label, val) {
  return `
    <div style="display:flex;flex-direction:column;gap:3px;">
      <span style="font-size:11px;font-weight:700;color:#64748b;text-transform:uppercase;letter-spacing:.04em;">${escHtml(label)}</span>
      <span style="font-size:13.5px;color:#0f172a;word-break:break-word;">${val}</span>
    </div>
  `;
}

let _currentApproveAppId = null;
let _currentRejectAppId = null;

function notifyAdmin(msg, type) {
  if (typeof window.showAdminToast === 'function') {
    window.showAdminToast(msg, type);
  } else {
    const toast = document.getElementById('toast');
    if (toast) {
      toast.textContent = msg;
      toast.className = 'toast ' + (type === 'error' ? 'error' : type === 'info' ? '' : 'success');
      toast.classList.add('show');
      setTimeout(() => toast.classList.remove('show'), 4000);
    } else {
      console.log(`[ADMIN NOTIFY ${type}] ${msg}`);
    }
  }
}

async function verifyPaymentInReview(paymentId) {
  const btn = document.getElementById('btnVerifyPayInReview');
  if (btn) {
    btn.disabled = true;
    btn.textContent = 'Verifying...';
  }

  try {
    await verifyAdminPayment(paymentId);
    notifyAdmin('✓ Payment verified and marked as Paid.', 'success');
    if (_currentReviewAppId) {
      reviewApplication(_currentReviewAppId);
    }
    loadAdminApplications();
  } catch (err) {
    alert('Payment verification failed: ' + (err.message || 'Server error'));
    if (btn) {
      btn.disabled = false;
      btn.textContent = '✓ Verify Payment (Mark as Paid)';
    }
  }
}

async function rejectPaymentInReview(paymentId) {
  const reason = prompt('Please enter the reason for marking this payment as Failed:');
  if (reason === null) return;

  const btn = document.getElementById('btnRejectPayInReview');
  if (btn) {
    btn.disabled = true;
    btn.textContent = 'Updating...';
  }

  try {
    await rejectAdminPayment(paymentId, reason);
    notifyAdmin('Payment marked as Failed.', 'info');
    if (_currentReviewAppId) {
      reviewApplication(_currentReviewAppId);
    }
    loadAdminApplications();
  } catch (err) {
    alert('Failed to mark payment: ' + (err.message || 'Server error'));
    if (btn) {
      btn.disabled = false;
      btn.textContent = '✕ Mark as Failed';
    }
  }
}

function approveApplicationPrompt(appId, name, memberId, paymentStatus) {
  if (paymentStatus !== 'Paid') {
    alert('⚠️ Cannot approve application: Payment is currently ' + (paymentStatus || 'Not Submitted') + '.\n\nPlease verify the payment first using the "Verify Payment" button above.');
    return;
  }

  _currentApproveAppId = appId;
  const modal = document.getElementById('approveConfirmModal');
  if (!modal) return;

  document.getElementById('approveModalAppId').textContent = 'APL' + String(appId).padStart(6, '0') + ` (#${appId})`;
  document.getElementById('approveModalName').textContent = name || '—';
  document.getElementById('approveModalMemberId').textContent = memberId ? `${memberId} (Existing Member)` : 'New Member (Auto-generated)';

  const notice = document.getElementById('approveModalTypeNotice');
  if (notice) {
    if (memberId) {
      notice.style.background = '#e0f2fe';
      notice.style.color = '#0369a1';
      notice.innerHTML = `<strong>Existing Member Update:</strong> Approving this application will UPDATE the existing <code>${escHtml(memberId)}</code> profile row in the <code>members</code> table without inserting any duplicate member row.`;
    } else {
      notice.style.background = '#f5f3ff';
      notice.style.color = '#6d28d9';
      notice.innerHTML = `<strong>New Member Registration:</strong> Approving this application will generate exactly ONE new Member ID and activate the membership.`;
    }
  }

  const btn = document.getElementById('btnConfirmApprove');
  if (btn) {
    btn.disabled = false;
    btn.textContent = 'Confirm Approval';
    btn.onclick = () => executeApplicationApproval(appId);
  }

  modal.style.display = 'flex';
}

function closeApproveModal() {
  const modal = document.getElementById('approveConfirmModal');
  if (modal) modal.style.display = 'none';
  _currentApproveAppId = null;
}

async function executeApplicationApproval(appId) {
  const targetId = appId || _currentApproveAppId;
  if (!targetId) {
    alert('No application selected for approval.');
    return;
  }

  const btn = document.getElementById('btnConfirmApprove');
  if (btn) {
    btn.disabled = true;
    btn.textContent = 'Approving...';
  }

  try {
    const res = await approveAdminApplication(targetId);
    closeApproveModal();
    const approvedMid = res.data?.member_id || '';
    notifyAdmin(`✓ Application approved! Member ${approvedMid} is now ACTIVE in the Public Directory.`, 'success');
    if (_currentReviewAppId === targetId) {
      reviewApplication(targetId);
    }
    loadAdminApplications();
    updateAdminApplicationCounters();
  } catch (err) {
    alert('Approval failed: ' + (err.message || 'Server error'));
    if (btn) {
      btn.disabled = false;
      btn.textContent = 'Confirm Approval';
    }
  }
}

function rejectApplicationPrompt(appId, name) {
  _currentRejectAppId = appId;
  const modal = document.getElementById('rejectReasonModal');
  if (!modal) return;

  document.getElementById('rejectModalAppId').textContent = 'APL' + String(appId).padStart(6, '0') + ` (#${appId})`;
  document.getElementById('rejectModalName').textContent = name || '—';
  const textarea = document.getElementById('rejectReasonTextarea');
  if (textarea) textarea.value = '';

  const btn = document.getElementById('btnConfirmReject');
  if (btn) {
    btn.disabled = false;
    btn.textContent = 'Confirm Rejection';
    btn.onclick = () => executeApplicationRejection(appId);
  }

  modal.style.display = 'flex';
}

function closeRejectModal() {
  const modal = document.getElementById('rejectReasonModal');
  if (modal) modal.style.display = 'none';
  _currentRejectAppId = null;
}

async function executeApplicationRejection(appId) {
  const targetId = appId || _currentRejectAppId;
  if (!targetId) {
    alert('No application selected for rejection.');
    return;
  }

  const textarea = document.getElementById('rejectReasonTextarea');
  const reason = (textarea?.value || '').trim();

  const btn = document.getElementById('btnConfirmReject');
  if (btn) {
    btn.disabled = true;
    btn.textContent = 'Rejecting...';
  }

  try {
    await rejectAdminApplication(targetId, reason);
    closeRejectModal();
    notifyAdmin('Application rejected.', 'info');
    if (_currentReviewAppId === targetId) {
      reviewApplication(targetId);
    }
    loadAdminApplications();
    updateAdminApplicationCounters();
  } catch (err) {
    alert('Rejection failed: ' + (err.message || 'Server error'));
    if (btn) {
      btn.disabled = false;
      btn.textContent = 'Confirm Rejection';
    }
  }
}

function viewPaymentProof(appId, proofUrl) {
  const modal = document.getElementById('proofPreviewModal');
  const img = document.getElementById('proofPreviewImg');
  const frame = document.getElementById('proofPreviewFrame');
  const placeholder = document.getElementById('proofPreviewPlaceholder');
  if (!modal) return;

  img.style.display = 'none';
  frame.style.display = 'none';
  placeholder.style.display = 'none';

  const fullUrl = `${getApiBase()}${proofUrl}`;

  if (proofUrl.toLowerCase().endsWith('.pdf')) {
    frame.src = fullUrl;
    frame.style.display = 'block';
  } else {
    img.src = fullUrl;
    img.style.display = 'inline-block';
  }

  modal.style.display = 'flex';
}

function closeProofModal() {
  const modal = document.getElementById('proofPreviewModal');
  if (modal) modal.style.display = 'none';
  const frame = document.getElementById('proofPreviewFrame');
  if (frame) frame.src = '';
  const img = document.getElementById('proofPreviewImg');
  if (img) img.src = '';
}

document.addEventListener('DOMContentLoaded', function () {
  updateAdminApplicationCounters();
});
