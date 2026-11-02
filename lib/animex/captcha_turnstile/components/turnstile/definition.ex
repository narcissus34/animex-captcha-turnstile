defmodule AnimEx.CaptchaTurnstile.Components.Turnstile.Definition do
  use AnimEx.Web.Live.Component.Definition

  def define() do
    quote do
      attrs(Basic)
      attrs(Geometry, defaults: [width: {:percent, 100}])
      attrs(JavaScript)

      attr(:id, :string, default: nil)
      attr(:sitekey, :string, required: true)
      attr(:action, :string, default: nil)
      attr(:token_key, :string, default: "animexTurnstileToken")
      attr(:button, :string, default: nil)
      attr(:theme, :string, default: "auto")
    end
  end
end
EOF