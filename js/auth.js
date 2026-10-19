/* ICMTA member session — front end.
 *
 * What this file is NOT: it is not the security. There is no password here,
 * no secret, and no check that matters. Everything in this file can be
 * edited by anyone with a browser, and none of it would get them a phone
 * number, because the server decides what to send based on the token, and
 * the token can only be obtained with a code delivered to an address that
 * is already on the member records.
 *
 * What this file IS: the bit that keeps the token, sends it along, and
 * decides what the page shows.
 */
(function (w) {
  "use strict";

  // Gated pages load this twice — once in <head> for the gate, once before
  // </body> with every other page. Second run does nothing.
  if (w.ICMTAAuth) return;

  // Point this at the deployed backend. One line, one place.
  // The API is served from the same origin as the site (PUBLIC_API_URL),
  // so the default is a relative path: "" + "/api/..." = "/api/...".
  // That survives the move from stage.icmta.net to www.icmta.in untouched.
  // Only set window.ICMTA_API_BASE if the API ever moves to its own host.
  
  // Local development: use the Node.js backend.
  // Production: use the same-origin API.
  var API = (
    w.ICMTA_API_BASE ||
    (
      w.location.hostname === "localhost" ||
      w.location.hostname === "127.0.0.1"
        ? "http://localhost:5000"
        : ""
    )
  ).replace(/\/+$/, "");

  var KEY = "ICMTAMemberSession";


function load()   {
    try {
      var raw = w.localStorage.getItem(KEY);
      if (!raw) return null;
      var s = JSON.parse(raw);
      if (!s || !s.token || !s.expires_at) return null;
      if (Date.now() > s.expires_at) { w.localStorage.removeItem(KEY); return null; }
      return s;
    } catch (e) { return null; }   // private windows and blocked storage throw
  }

  function save(s) {
    try { w.localStorage.setItem(KEY, JSON.stringify(s)); } catch (e) {}
  }

  function clear() {
    try { w.localStorage.removeItem(KEY); } catch (e) {}
  }

  function token() { var s = load(); return s ? s.token : null; }

  async function call(path, opts) {
    opts = opts || {};
    var headers = Object.assign({ "Content-Type": "application/json" }, opts.headers || {});
    var t = token();
    if (t) headers.Authorization = "Bearer " + t;

    var res = await fetch(API + path, {
      method: opts.method || "GET",
      headers: headers,
      body: opts.body ? JSON.stringify(opts.body) : undefined,
    });

    var out = null;
    try { out = await res.json(); } catch (e) {}

    // Token rejected — the session is over, whatever localStorage thinks.
    if (res.status === 401 && t) { clear(); }

    if (!res.ok || !out || out.success === false) {
     // Show the actual backend error so we can diagnose failed sign-in.
throw new Error(
  (out && (out.error || out.message || out.detail)) ||
  "Request failed (" + res.status + ")"
);
    }
    return out;
  }

  var Auth = {
    isSignedIn: function () { return !!load(); },
    session: load,
    memberId: function () { var s = load(); return s ? s.member_id : null; },
    isAdmin: function () { var s = load(); return !!(s && s.is_admin); },
    email: function () { var s = load(); return s ? s.email : null; },

    // Request a one-time code to be sent to the member's email address.
requestCode: async function (email) {
  return await call("/api/member/request-code", {
    method: "POST",
    body: { email: email }
  });
},

// Request a one-time code to be sent to the member's email address for registration.
    registerRequestCode: async function (email) {
  return await call("/api/member/register/request-code", {
    method: "POST",
    body: { email: email }
  });
},

 // Verify the one-time code and get a session token.   
verify: async function (email, code, purpose = "signin") {
  // Verify the OTP with the backend.
  var out = await call("/api/member/verify", {
    method: "POST",
    body: {
      email: email,
      code: code,
      purpose: purpose
    }
  });
  // Do not save an incomplete or invalid session.
  if (!out || !out.token) {
    throw new Error(
      (out && (out.error || out.message)) ||
      "Verification succeeded without an authentication token."
    );
  }

  // Save the authenticated session.
  save({
    token: out.token,
    member_id: out.member_id || null,
    is_admin: !!out.is_admin,
    email: String(email).trim().toLowerCase(),
    expires_at:
      Date.now() +
      (Number(out.expires_in_minutes || 60) * 60000) -
      30000
  });

  return out;
},


    signOut: function (redirectTo) {
      clear();
      if (redirectTo) w.location.href = redirectTo;
      else w.location.reload();
    },

    // Gate a whole page. Put it in <head> so nothing paints first.
    require: function (signInUrl) {
      if (Auth.isSignedIn()) return true;
      var back = encodeURIComponent(w.location.pathname + w.location.search);
      w.location.replace(signInUrl + "?next=" + back);
      return false;
    },

    api: call,
  };

  // Swap "Sign in" for "Sign out" in the header, on every page.
    Auth.paintHeader = function () {
    var slot = document.querySelector("[data-icm-authslot]");
    if (!slot) return;

    var base = slot.getAttribute("data-icm-base") || "";
var signInUrl = "/pages/sign-in.html";

    if (Auth.isSignedIn()) {
      var email = Auth.email() || "";
      var initials = email ? email.charAt(0).toUpperCase() : "U";

      slot.innerHTML = `
        <div class="icm-profile-menu">
          <button
            type="button"
            class="icm-profile-trigger"
            aria-label="Open profile menu"
            aria-expanded="false"
            title="${email.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;")}"
          >
            <span class="icm-profile-avatar">${initials}</span>
          </button>

          <div class="icm-profile-dropdown" hidden>
            <div class="icm-profile-email">${email.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")}</div>
            <a href="${base}pages/member-profile.html" class="icm-profile-link">My Profile</a>
            <button type="button" class="icm-profile-signout">Sign Out</button>
          </div>
        </div>
      `;

      var menu = slot.querySelector(".icm-profile-menu");
      var trigger = slot.querySelector(".icm-profile-trigger");
      var dropdown = slot.querySelector(".icm-profile-dropdown");
      var signOut = slot.querySelector(".icm-profile-signout");

      trigger.addEventListener("click", function () {
        var isOpen = !dropdown.hidden;
        dropdown.hidden = isOpen;
        trigger.setAttribute("aria-expanded", String(!isOpen));
      });

      document.addEventListener("click", function (event) {
        if (!menu.contains(event.target)) {
          dropdown.hidden = true;
          trigger.setAttribute("aria-expanded", "false");
        }
      });

      signOut.addEventListener("click", function () {
        Auth.signOut("/");
      });
    } else {
      slot.innerHTML =
  '<a href="' + signInUrl + '" class="icm-signin">Sign in</a>';
    }
  };

  document.addEventListener("DOMContentLoaded", Auth.paintHeader);
  w.ICMTAAuth = Auth;
})(window);
