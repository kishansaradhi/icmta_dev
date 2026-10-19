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
    // Keep old frontend-friendly `id`, while exposing the numeric DB event_id too.
    return Object.assign({}, e, { id: String(e.event_id) });
  }

  async function submitEvent(eventData) {
    const result = await request(`${apiBase()}/api/events`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(eventData)
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
    const result = await request(`${apiBase()}/api/events`);
    return result.data.map(mapEvent);
  }

  async function getEventById(id) {
    try {
      const result = await request(`${apiBase()}/api/events/${encodeURIComponent(id)}`);
      return mapEvent(result.data);
    } catch (_) {
      return null;
    }
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
    approveEvent,
    rejectEvent
  };
})(window);
