const API_BASE_URL = "http://localhost:5000";

async function loadMembersFromBackend() {
    try {
        const response = await fetch(`${API_BASE_URL}/api/members`);

        if (!response.ok) {
            throw new Error(`Failed to load members: ${response.status}`);
        }

        const result = await response.json();

        if (!result.success || !Array.isArray(result.data)) {
            throw new Error("Invalid members API response");
        }

        return result.data.map(member => ({
            id: member.member_id,
            name: member.name,
            qualification: member.qualification,
            designation: member.designation,
            department: member.department,
            college: member.institution,
            city: member.city,
            state: member.state_province,
            country: member.country,
            expertise: member.expertise,
            photo: member.photo_url,

            guideship: member.guideship || "",
            researchSupervisor: member.researchSupervisor || "",
            collegeAddress: member.collegeAddress || "",
            mobile: member.mobile || "",
            professionalEmail: member.professional_email || "",
            personalEmail: member.personal_email || ""
        }));

    } catch (error) {
        console.error("Backend member loading failed:", error);
        return [];
    }
}
async function adminLogin(user_id, password) {
    const response = await fetch(`${API_BASE_URL}/api/admin/login`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            user_id,
            password
        })
    });

    const result = await response.json();

    if (!response.ok || !result.success) {
        throw new Error(result.error || "Admin login failed");
    }

    return result;
}
async function createMemberInBackend(form) {

    const token = localStorage.getItem("ICMTAdminToken");

    if (!token) {
        throw new Error("Admin session expired. Please log in again.");
    }

    const formData = new FormData();

    formData.append("name", form.name.value.trim());
    formData.append("qualification", form.qualification.value.trim());
    formData.append("designation", form.designation.value.trim());
    formData.append("department", form.department.value.trim());
    formData.append("institution", form.college.value.trim());
    formData.append("city", form.city.value.trim());
    formData.append("state_province", form.state.value.trim());
    formData.append("country", form.country.value.trim());
    formData.append("expertise", form.expertise.value.trim());

    if (form.professionalEmail) {
        formData.append("professional_email", form.professionalEmail.value.trim());
    }

    if (form.personalEmail) {
        formData.append("personal_email", form.personalEmail.value.trim());
    }

    if (form.mobile) {
        formData.append("mobile", form.mobile.value.trim());
    }

    if (form.guideship) {
        formData.append("guideship", form.guideship.value.trim());
    }

    if (form.researchSupervisor) {
        formData.append("researchSupervisor", form.researchSupervisor.value.trim());
    }

    if (form.collegeAddress) {
        formData.append("college_address", form.collegeAddress.value.trim());
    }

    const photoInput = document.getElementById("adminPhotoInput");

    if (photoInput && photoInput.files.length > 0) {
        formData.append("photo", photoInput.files[0]);
    }

    const response = await fetch(`${API_BASE_URL}/api/admin/members`, {
        method: "POST",
        headers: {
            "Authorization": `Bearer ${token}`
        },
        body: formData
    });

    const result = await response.json();

    if (!response.ok || !result.success) {
        throw new Error(result.error || "Could not create member.");
    }

    return result.data;
}
async function uploadMemberPhoto(memberId, file) {

    const token = localStorage.getItem("ICMTAdminToken");

    if (!token) {
        throw new Error("Admin session expired. Please log in again.");
    }

    const formData = new FormData();

    // The backend expects the field name to be exactly "photo"
    formData.append("photo", file);

    const response = await fetch(
        `${API_BASE_URL}/api/admin/members/${encodeURIComponent(memberId)}`,
        {
            method: "PUT",
            headers: {
                "Authorization": `Bearer ${token}`
            },
            body: formData
        }
    );

    const result = await response.json();

    if (!response.ok || !result.success) {
        throw new Error(result.error || "Photo upload failed.");
    }

    return result.data;
}

async function verifyExistingMember(memberId, email) {
    const apiBase = window.API_BASE_URL || (
        window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
            ? (window.location.port === "5000" ? "" : "http://localhost:5000")
            : ""
    );
    const response = await fetch(`${apiBase}/api/members/verify`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            member_id: memberId,
            email: email
        })
    });

    const result = await response.json();
    if (!response.ok || !result.success) {
        throw new Error(result.detail || "Member not found. Please check your Member ID and registered email.");
    }

    return result.data;
}

function getAdminAuthToken() {
    return localStorage.getItem("ICMTAdminToken") || "";
}

function getApiBase() {
    return window.API_BASE_URL || (
        window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
            ? (window.location.port === "5000" ? "" : "http://localhost:5000")
            : ""
    );
}

async function getAdminMetrics() {
    const token = getAdminAuthToken();
    const res = await fetch(`${getApiBase()}/api/admin/metrics`, {
        headers: { "Authorization": `Bearer ${token}` }
    });
    const result = await res.json();
    if (!res.ok || !result.success) throw new Error(result.detail || "Failed to load metrics");
    return result.data;
}

async function getAdminApplications(status, memberType, payment) {
    const token = getAdminAuthToken();
    const params = new URLSearchParams();
    if (status && status !== "All") params.append("status", status);
    if (memberType && memberType !== "All") params.append("member_type", memberType);
    if (payment && payment !== "All") params.append("payment", payment);

    const qs = params.toString() ? `?${params.toString()}` : "";
    const res = await fetch(`${getApiBase()}/api/admin/applications${qs}`, {
        headers: { "Authorization": `Bearer ${token}` }
    });
    const result = await res.json();
    if (!res.ok || !result.success) throw new Error(result.detail || "Failed to load applications");
    return result.data;
}

async function getAdminApplicationDetail(applicationId) {
    const token = getAdminAuthToken();
    const res = await fetch(`${getApiBase()}/api/admin/applications/${applicationId}`, {
        headers: { "Authorization": `Bearer ${token}` }
    });
    const result = await res.json();
    if (!res.ok || !result.success) throw new Error(result.detail || "Failed to load application details");
    return result.data;
}

async function verifyAdminPayment(paymentId) {
    const token = getAdminAuthToken();
    const res = await fetch(`${getApiBase()}/api/admin/payments/${paymentId}/verify`, {
        method: "POST",
        headers: { "Authorization": `Bearer ${token}` }
    });
    const result = await res.json();
    if (!res.ok || !result.success) throw new Error(result.detail || "Failed to verify payment");
    return result.data;
}

async function rejectAdminPayment(paymentId, reason) {
    const token = getAdminAuthToken();
    const res = await fetch(`${getApiBase()}/api/admin/payments/${paymentId}/reject`, {
        method: "POST",
        headers: {
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ reason: reason || "" })
    });
    const result = await res.json();
    if (!res.ok || !result.success) throw new Error(result.detail || "Failed to reject payment");
    return result.data;
}

async function approveAdminApplication(applicationId) {
    const token = getAdminAuthToken();
    const res = await fetch(`${getApiBase()}/api/admin/applications/${applicationId}/approve`, {
        method: "POST",
        headers: { "Authorization": `Bearer ${token}` }
    });
    const result = await res.json();
    if (!res.ok || !result.success) throw new Error(result.detail || "Failed to approve application");
    return result.data;
}

async function rejectAdminApplication(applicationId, reason) {
    const token = getAdminAuthToken();
    const res = await fetch(`${getApiBase()}/api/admin/applications/${applicationId}/reject`, {
        method: "POST",
        headers: {
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ reason: reason || "" })
    });
    const result = await res.json();
    if (!res.ok || !result.success) throw new Error(result.detail || "Failed to reject application");
    return result.data;
}