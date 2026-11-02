(function() {
  if (window._AnimExCaptchaTurnstileLoaded) return;
  window._AnimExCaptchaTurnstileLoaded = true;

  window.AnimExCaptchaTurnstile = {
    apiScriptLoaded: false,
    apiScriptLoading: false,

    // Loads https://challenges.cloudflare.com/turnstile/v0/api.js the first
    // time a widget appears in the DOM (same pattern as
    // AnimExAuthGAuth.loadScript — nothing is preloaded in <head>).
    loadScript() {
      if (this.apiScriptLoaded || this.apiScriptLoading) return;
      if (!document.querySelector("[data-animex-turnstile-widget]")) return;

      if (window.turnstile) {
        // Host already ships the api.js; no need to inject it again.
        this.apiScriptLoaded = true;
        this.initWidgets();
        return;
      }

      this.apiScriptLoading = true;

      const script = document.createElement("script");
      script.src = "https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit";
      script.async = true;
      script.defer = true;
      script.onload = () => {
        this.apiScriptLoaded = true;
        this.apiScriptLoading = false;
        this.initWidgets();
      };
      script.onerror = () => {
        this.apiScriptLoading = false;
      };
      document.head.appendChild(script);
    },

    // Explicit render of every pending Turnstile widget, then wiring of the
    // claim button each one is bound to.
    initWidgets() {
      if (!this.apiScriptLoaded || !window.turnstile) return;

      document.querySelectorAll("[data-animex-turnstile-widget]").forEach((el) => {
        if (el.dataset.animexTurnstileReady) return;
        const sitekey = el.dataset.animexTurnstileSitekey;
        if (!sitekey) return;

        el.dataset.animexTurnstileReady = "true";

        const tokenKey = el.dataset.animexTurnstileTokenKey || "animexTurnstileToken";
        const options = {
          sitekey: sitekey,
          theme: el.dataset.animexTurnstileTheme || "auto",
          callback: (token) => {
            window[tokenKey] = token;
            this.setButtonEnabled(el, true);
          },
          "expired-callback": () => {
            window[tokenKey] = null;
            this.setButtonEnabled(el, false);
          },
          "error-callback": () => {
            window[tokenKey] = null;
            this.setButtonEnabled(el, false);
          }
        };
        const action = el.dataset.animexTurnstileAction;
        if (action) options.action = action;

        const widgetId = window.turnstile.render(el, options);
        el.dataset.animexTurnstileWidgetId = String(widgetId);
        window[tokenKey + "WidgetId"] = widgetId;

        this.bindClaimButton(el);
      });
    },

    // The claim button is owned by the host app; the widget only enables it
    // once a token is available and dispatches its clicks.
    bindClaimButton(el) {
      const selector = el.dataset.animexTurnstileButton;
      const target = el.dataset.animexTurnstileTarget;
      if (!selector || !target) return;

      const button = document.querySelector(selector);
      if (!button || button.dataset.animexTurnstileClaimWired) return;
      button.dataset.animexTurnstileClaimWired = "true";

      button.addEventListener("click", (event) => {
        event.preventDefault();
        event.stopImmediatePropagation();
        this.claim(el);
      });
    },

    claim(el) {
      const tokenKey = el.dataset.animexTurnstileTokenKey || "animexTurnstileToken";
      const token = window[tokenKey];
      if (!token) return;

      // Same dispatch pattern as AnimExAuthGAuth: replay the claim through
      // a hidden [live-click] button so it arrives at the LiveView engine
      // as app:<target> with {action, params}.
      const target = el.dataset.animexTurnstileTarget;
      const action = el.dataset.animexTurnstileAction || "turnstile_claim";
      const button = document.createElement("button");
      button.type = "button";
      button.style.display = "none";
      button.setAttribute("live-click", "app:" + target);
      button.setAttribute("live-value-action", action);
      button.setAttribute(
        "live-value-params",
        JSON.stringify({ turnstile_token: token })
      );
      document.body.appendChild(button);
      button.click();
      setTimeout(() => button.remove(), 2000);

      window[tokenKey] = null;
      const widgetId = window[tokenKey + "WidgetId"];
      if (widgetId !== undefined && window.turnstile) window.turnstile.reset(widgetId);
      this.setButtonEnabled(el, false);
    },

    setButtonEnabled(el, enabled) {
      const selector = el.dataset.animexTurnstileButton;
      if (!selector) return;

      const button = document.querySelector(selector);
      if (!button) return;

      if (enabled) {
        button.disabled = false;
        button.removeAttribute("disabled");
      } else {
        button.disabled = true;
        button.setAttribute("disabled", "disabled");
      }
    }
  };

  // ---------- Boot ----------
  function bootAll() {
    window.AnimExCaptchaTurnstile.loadScript();
    window.AnimExCaptchaTurnstile.initWidgets();
  }

  new MutationObserver(() => bootAll()).observe(document.documentElement, {
    childList: true,
    subtree: true
  });

  document.addEventListener("DOMContentLoaded", () => bootAll());
  bootAll();
})();
