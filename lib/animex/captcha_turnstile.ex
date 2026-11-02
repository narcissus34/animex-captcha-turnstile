defmodule AnimEx.CaptchaTurnstile do
  @moduledoc """
  AnimEx module shipping the client glue for Cloudflare Turnstile widgets.

  `priv/static/module.js` is inlined into the document head by
  `AnimEx.Web.Live.Modules` and performs widget rendering, token capture
  and claim dispatch. No Elixir-side view code is required; use the
  `data-animex-turnstile-*` attributes documented in README.md.
  """

  @doc false
  def app_boot do
    :ok
  end
end
