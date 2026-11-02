defmodule AnimEx.CaptchaTurnstile do
  @moduledoc """
  Discovery shim for the `:animex_captcha_turnstile` OTP application.

  `AnimEx.Modules` maps the app to this top-level module; the captcha UI
  lives in `AnimEx.CaptchaTurnstile.Components` and the client glue in the
  app's `priv/static/module.js` (inlined into the document head by
  `AnimEx.Web.Live.Modules`).
  """

  use AnimEx.Module
end
