defmodule AnimEx.CaptchaTurnstile.Components do
  use Phoenix.Component

  attr :sitekey, :string, required: true
  attr :id, :string, default: nil
  attr :action, :string, default: nil
  attr :token_key, :string, default: "animexTurnstileToken"
  attr :button, :string, default: nil
  attr :theme, :string, default: "auto"
  attr :class, :string, default: nil

  def turnstile(assigns) do
    ~H"""
    <div
      id={@id}
      class={@class}
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
