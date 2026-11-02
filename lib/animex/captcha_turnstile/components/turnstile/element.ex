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
    <.container
      id={@id}
      data={
        %{
          "animex-turnstile-widget" => true,
          "animex-turnstile-sitekey" => @sitekey,
          "animex-turnstile-action" => @action,
          "animex-turnstile-token-key" => @token_key,
          "animex-turnstile-button" => @button,
          "animex-turnstile-theme" => @theme
        }
      }
    >
    </.container>
    """
  end
end
