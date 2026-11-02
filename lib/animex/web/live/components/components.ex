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

  attr :sitekey, :string, required: true
  attr :id, :string, default: nil
  attr :action, :string, default: nil
  attr :token_key, :string, default: "animexTurnstileToken"
  attr :app_target, :string, default: nil
  attr :button_id, :string, default: nil
  attr :theme, :string, default: "auto"
  attr :class, :string, default: nil
  attr :disabled, :boolean, default: true
  slot :inner_block

  def turnstile_button(assigns) do
    button_id = assigns[:button_id] || "#{assigns.id || "turnstile"}-button"
    assigns = assign(assigns, :button_id, button_id)

    ~H"""
    <div class="animex-turnstile-button" data-animex-turnstile-button>
      <.turnstile
        id={@id}
        sitekey={@sitekey}
        action={@action}
        token_key={@token_key}
        button={"#" <> @button_id}
        theme={@theme}
      />
      <button
        id={@button_id}
        type="button"
        class={@class}
        disabled={@disabled}
        data-animex-turnstile-claim
        data-token-key={@token_key}
        data-app-target={@app_target}
        data-action={@action}
      >
        {render_slot(@inner_block)}
      </button>
    </div>
    """
  end

  def button_turnstile(assigns) do
    turnstile_button(assigns)
  end
end
EOF
echo written