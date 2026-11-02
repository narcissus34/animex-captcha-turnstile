defmodule AnimEx.CaptchaTurnstile.Components.Turnstile.Element do
  use AnimEx.Web.Live.Component.Stateless

  def element(assigns) do
    ~A"""
    <.container
      id={@id}
      data={
        %{
          "animex-turnstile-widget" => true,
          "animex-turnstile-sitekey" => @sitekey,
          "animex-turnstile-action" => @action,
          "animex-turnstile-target" => @target,
          "animex-turnstile-token-key" => @token_key,
          "animex-turnstile-button" => @button,
          "animex-turnstile-theme" => @theme
        }
      }
      width={@width}
    >
    </.container>
    """
  end
end
