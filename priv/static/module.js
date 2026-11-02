(function() {
  if (window._AnimExCaptchaTurnstileLoaded) return;
  window._AnimExCaptchaTurnstileLoaded = true;

  // Ensure the Turnstile API script is present.
  (function ensureScript() {
    if (document.querySelector('script[src*="challenges.cloudflare.com/turnstile/v0/api.js"]')) return;
    var s = document.createElement("script");
    s.src = "https://challenges.cloudflare.com/turnstile/v0/api.js";
    s.async = true;
    s.defer = true;
    (document.head || document.documentElement).appendChild(s);
  })();

  function root() {
    return document.body || document.documentElement;
  }

  function pushClaim(btn, token) {
    var target = btn.getAttribute("data-app-target") || "mines";
    var action = btn.getAttribute("data-action") || "mine_claim";
    var eventName = "app:" + target;
    var payload = { action: action, params: { turnstile_token: token } };
    var tryPush = function() {
      if (window.liveSocket && typeof window.liveSocket.pushEventTo === "function") {
        try {
          window.liveSocket.pushEventTo(btn, eventName, payload);
          return true;
        } catch (e) {
          return false;
        }
      }
      return false;
    };
    if (!tryPush()) {
      var attempts = 0;
      var timer = setInterval(function() {
        attempts += 1;
        if (tryPush() || attempts > 50) clearInterval(timer);
      }, 100);
    }
  }

  function initWidgets() {
    root().querySelectorAll("[data-animex-turnstile-widget]:not([data-axts-init])").forEach(function(el) {
      el.setAttribute("data-axts-init", "1");
      var sitekey = el.getAttribute("data-sitekey");
      var action = el.getAttribute("data-action") || undefined;
      var tokenKey = el.getAttribute("data-token-key") || "animexTurnstileToken";
      var buttonSelector = el.getAttribute("data-button");
      var theme = el.getAttribute("data-theme") || "auto";

      var renderWidget = function() {
        if (!window.turnstile) {
          return setTimeout(renderWidget, 100);
        }
        var id = window.turnstile.render(el, {
          sitekey: sitekey,
          action: action,
          theme: theme,
          callback: function(token) {
            window[tokenKey] = token;
            window[tokenKey + "WidgetId"] = id;
            if (buttonSelector) {
              var btn = document.querySelector(buttonSelector);
              if (btn) {
                btn.disabled = false;
                btn.removeAttribute("disabled");
              }
            }
          },
          "expired-callback": function() {
            window[tokenKey] = null;
          },
          "error-callback": function() {
            window[tokenKey] = null;
          }
        });
        window[tokenKey + "WidgetId"] = id;
      };
      renderWidget();
    });
  }

  function initButtons() {
    root().querySelectorAll("[data-animex-turnstile-claim]:not([data-axts-init])").forEach(function(btn) {
      btn.setAttribute("data-axts-init", "1");
      var tokenKey = btn.getAttribute("data-token-key") || "animexTurnstileToken";

      btn.addEventListener("click", function(event) {
        event.preventDefault();
        event.stopImmediatePropagation();
        var token = window[tokenKey];
        if (!token) return;
        var widgetId = window[tokenKey + "WidgetId"];
        pushClaim(btn, token);
        window[tokenKey] = null;
        setTimeout(function() {
          if (widgetId && window.turnstile) {
            window.turnstile.reset(widgetId);
          }
          btn.disabled = true;
          btn.setAttribute("disabled", "disabled");
        }, 250);
      });
    });
  }

  function tick() {
    try { initWidgets(); initButtons(); } catch (e) {}
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", tick);
  } else {
    tick();
  }

  // Keep handling elements added by LiveView re-renders.
  (function observe() {
    var target = root();
    if (!target || !window.MutationObserver) {
      setTimeout(observe, 100);
      return;
    }
    var observer = new MutationObserver(tick);
    observer.observe(target, { childList: true, subtree: true });
  })();
})();
