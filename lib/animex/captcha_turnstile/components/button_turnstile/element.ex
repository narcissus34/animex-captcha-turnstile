defmodule AnimEx.CaptchaTurnstile.Components.ButtonTurnstile.Element do
  use AnimEx.Web.Live.Component.Stateless

  def element(assigns) do
    button_id = assigns[:button_id] || "#{assigns[:id] || "button-turnstile"}-button"
    assigns = Phoenix.Component.assign(assigns, :button_id, button_id)

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
            "animex-turnstile-button" => "#" <> @button_id,
            "animex-turnstile-theme" => @theme,
            "animex-turnstile-invisible" => true
          }
        }
        width={0}
        height={0}
      >
      </.container>
      <.button
        id={@button_id}
        type={@type}
        disabled?={@disabled?}
        tooltip={@tooltip}
        {if Map.has_key?(assigns.__given__, :"--animate") and assigns[:"--animate"] != false, do: [{:"--animate", assigns[:"--animate"]}], else: []}
        {if Map.has_key?(assigns.__given__, :"--hover:animate") and assigns[:"--hover:animate"] != false, do: [{:"--hover:animate", assigns[:"--hover:animate"]}], else: []}
        {if Map.has_key?(assigns.__given__, :"--focus:animate") and assigns[:"--focus:animate"] != false, do: [{:"--focus:animate", assigns[:"--focus:animate"]}], else: []}
        {if Map.has_key?(assigns.__given__, :"--disabled:animate") and assigns[:"--disabled:animate"] != false, do: [{:"--disabled:animate", assigns[:"--disabled:animate"]}], else: []}
        {if Map.has_key?(assigns.__given__, :"--busy:animate") and assigns[:"--busy:animate"] != false, do: [{:"--busy:animate", assigns[:"--busy:animate"]}], else: []}
        --html-attrs={Map.merge(assigns[:"--html-attrs"] || %{}, if(@hidden?, do: %{"hidden" => true, "style" => "display: none"}, else: %{}))}
        {assigns_chain([
          Basic,
          {Background, prefixes: [
            [],
            [prefix: "hover:", parse_prefix: "hover:"],
            [prefix: "focus:", parse_prefix: "focus:"],
            [prefix: "disabled:", parse_prefix: "disabled:"],
            [prefix: "busy:", parse_prefix: "busy:"]
          ]},
          {Text, exclude: [:text], prefixes: [
            [prefix: "hover:", parse_prefix: "hover:"],
            [prefix: "focus:", parse_prefix: "focus:"],
            [prefix: "disabled:", parse_prefix: "disabled:"],
            [prefix: "busy:", parse_prefix: "busy:"]
          ]},
          {Border, prefixes: [
            [],
            [prefix: "hover:", parse_prefix: "hover:"],
            [prefix: "focus:", parse_prefix: "focus:"],
            [prefix: "disabled:", parse_prefix: "disabled:"],
            [prefix: "busy:", parse_prefix: "busy:"]
          ]},
          {Visibility, prefixes: [
            [],
            [prefix: "hover:", parse_prefix: "hover:"],
            [prefix: "busy:", parse_prefix: "busy:"]
          ]},
          {Geometry, prefixes: [
            [],
            [prefix: "hover:", parse_prefix: "hover:"],
            [prefix: "focus:", parse_prefix: "focus:"],
            [prefix: "disabled:", parse_prefix: "disabled:"],
            [prefix: "busy:", parse_prefix: "busy:"]
          ]},
          Position,
          JavaScript
        ], assigns)}>
        <.content block={@inner_block} />
        <.content block={@loader} />
      </.button>
    """
  end
end