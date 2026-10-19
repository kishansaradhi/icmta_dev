/**
 * Replace the existing js/eventDataService.js with this implementation.
 * It keeps the same public EventDataService function names but stores events in MySQL.
 */
(function (global) {
  "use strict";

  function apiBase() {
    return global.API_BASE_URL || (
      location.hostname === "localhost" || location.hostname === "127.0.0.1"
        ? "http://localhost:5000"
        : ""
    );
  }

  function token() {
    return localStorage.getItem("ICMTAdminToken") || "";
  }

  async function request(url, options) {
    const response = await fetch(url, options || {});
    const result = await response.json().catch(() => ({}));
    if (!response.ok || result.success === false) {
      throw new Error(result.detail || result.message || "Request failed");
    }
    return result;
  }

  function mapEvent(e) {
  return Object.assign({}, e, {
    id: String(e.event_id),

    title: e.event_title,
    category: e.event_category,

    startDate: e.event_date,
    endDate: e.event_date,

    startTime: e.start_time,
    endTime: e.end_time,

    mode: e.event_mode,

    poster: e.poster_url
  ? `${apiBase()}${e.poster_url}`
  : "",

    shortDescription: e.short_description,
    fullDescription: e.full_description,

    organizedBy: e.organized_by,
    inAssociationWith: e.in_association_with,

    registrationFee: e.registration_fee,
    registrationLink: e.registration_link,

    speakerName: e.speaker_name,
    speakerDesignation: e.speaker_designation,
    speakerInstitution: e.speaker_institution,

    coordinatorName: e.coordinator_name,
    contactNumber: e.contact_number,
    contactEmail: e.contact_email,

    registrationDeadline: e.registration_deadline
  });
}


async function submitEvent(eventData) {
  const formData = new FormData();

  formData.append("event_title", eventData.title || "");
  formData.append("event_category", eventData.category || "");
  formData.append("event_date", eventData.startDate || "");
  formData.append("registration_deadline", eventData.registrationDeadline || "");
  formData.append("start_time", eventData.startTime || "");
  formData.append("end_time", eventData.endTime || "");
  formData.append("event_mode", eventData.mode || "");

  formData.append("short_description", eventData.shortDescription || "");
  formData.append("full_description", eventData.fullDescription || "");
  formData.append("organized_by", eventData.organizedBy || "");
  formData.append("in_association_with", eventData.inAssociationWith || "");
  formData.append("registration_fee", eventData.registrationFee || "");
  formData.append("registration_link", eventData.registrationLink || "");

  formData.append("speaker_name", eventData.speakerName || "");
  formData.append("speaker_designation", eventData.speakerDesignation || "");
  formData.append("speaker_institution", eventData.speakerInstitution || "");

  formData.append("coordinator_name", eventData.coordinatorName || "");
  formData.append("contact_number", eventData.contactNumber || "");
  formData.append("contact_email", eventData.contactEmail || "");

  if (eventData.posterFile) {
    formData.append("eventPoster", eventData.posterFile);
  }

  // Use the signed-in member's session; do not use the admin token here.
  const session = global.ICMTAAuth?.session?.();
  const memberToken = session?.token;

  if (!memberToken) {
    throw new Error("Please sign in before submitting an event.");
  }

  const result = await request(`${apiBase()}/api/events`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${memberToken}`
    },
    body: formData
  });

  return mapEvent(result.data);
}


  async function getPendingEvents() {
    const result = await request(`${apiBase()}/api/admin/events?status=PENDING_APPROVAL`, {
      headers: { "Authorization": `Bearer ${token()}` }
    });
    return result.data.map(mapEvent);
  }

  async function getAllAdminEvents() {
    const result = await request(`${apiBase()}/api/admin/events`, {
      headers: { "Authorization": `Bearer ${token()}` }
    });
    return result.data.map(mapEvent);
  }

  
async function getEvents() {
  // Event visibility is decided by the backend based on the signed-in account.
  const session = global.ICMTAAuth?.session?.();
  const memberToken = session?.token;

  if (!memberToken) {
    throw new Error("Please sign in to view events.");
  }

  const result = await request(`${apiBase()}/api/events`, {
    headers: {
      Authorization: `Bearer ${memberToken}`
    }
  });

  return result.data.map(mapEvent);
}


  
async function getEventById(id) {
  try {
    const session = global.ICMTAAuth?.session?.();
    const memberToken = session?.token;

    if (!memberToken) {
      throw new Error("Please sign in to view event details.");
    }

    const result = await request(
      `${apiBase()}/api/events/${encodeURIComponent(id)}`,
      {
        headers: {
          Authorization: `Bearer ${memberToken}`
        }
      }
    );

    return mapEvent(result.data);
  } catch (_) {
    return null;
  }
}


  async function registerForEvent(eventId, registrationData) {
  const result = await request(
    `${apiBase()}/api/events/${encodeURIComponent(eventId)}/register`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(registrationData)
    }
  );

  return result.data;
}

  async function approveEvent(id) {
    await request(`${apiBase()}/api/admin/events/${encodeURIComponent(id)}/approve`, {
      method: "POST",
      headers: { "Authorization": `Bearer ${token()}` }
    });
    return true;
  }

  async function rejectEvent(id, reason) {
    await request(`${apiBase()}/api/admin/events/${encodeURIComponent(id)}/reject`, {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${token()}`,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ reason: reason || "" })
    });
    return true;
  }

 global.EventDataService = {
  submitEvent,
  getPendingEvents,
  getAllAdminEvents,
  getEvents,
  getEventById,
  registerForEvent,
  approveEvent,
  rejectEvent
};
})(window);
