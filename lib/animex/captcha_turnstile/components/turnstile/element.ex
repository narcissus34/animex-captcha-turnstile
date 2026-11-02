defmodule AnimEx.CaptchaTurnstile.Components.Turnstile.Element do
  use AnimEx.Web.Live.Component.Stateless

  def element(assigns) do
    assigns =
      assigns
      |> Map.put_new(:id, nil)
      |> Map.put_new(:action, nil)
      |> Map.put_new(:token_key, "animexTurnstileToken")
      |> Map.put_new(:button, nil)
      |> Map.put_new(:theme, "auto")

    ~A"""
    <div
      id={@id}
      data-animex-turnstile-widget
      data-sitekey={@sitekey}
      data-action={@action}
      data-token-key={@token_key}
      data-button={@button}
      data-theme={@theme}
    ></div>
    """
  end
end
EOF
echo rewritten