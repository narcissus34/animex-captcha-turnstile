defmodule AnimEx.CaptchaTurnstile.Components.ButtonTurnstile.Definition do
  use AnimEx.Web.Live.Component.Definition

  def define() do
    quote do
      attrs(Basic)

      attrs(Background,
        defaults: [
          "background-color": :white
        ]
      )

      attrs(Background, prefix: "hover:")
      attrs(Background, prefix: "focus:")
      attrs(Background, prefix: "disabled:")
      attrs(Background, prefix: "busy:")
      attrs(Text, prefix: "hover:", exclude: [:text])
      attrs(Text, prefix: "focus:", exclude: [:text])
      attrs(Text, prefix: "disabled:", exclude: [:text])
      attrs(Text, prefix: "busy:", exclude: [:text])
      attrs(Border)
      attrs(Border, prefix: "hover:")
      attrs(Border, prefix: "focus:")
      attrs(Border, prefix: "disabled:")
      attrs(Border, prefix: "busy:")
      attrs(Visibility)
      attrs(Visibility, prefix: "hover:")
      attrs(Visibility, prefix: "busy:")

      attrs(Geometry,
        defaults: [
          width: 200,
          height: 50
        ]
      )

      attrs(Geometry, prefix: "hover:")
      attrs(Geometry, prefix: "focus:")
      attrs(Geometry, prefix: "disabled:")
      attrs(Geometry, prefix: "busy:")

      attrs(Position)
      attrs(JavaScript)

      attr :"--animate", :map, default: nil
      attr :"--hover:animate", :map, default: nil
      attr :"--focus:animate", :map, default: nil
      attr :"--disabled:animate", :map, default: nil
      attr :"--busy:animate", :map, default: nil

      attr :disabled?, :boolean, default: false
      attr :hidden?, :boolean, default: false
      attr :tooltip, :string, default: nil
      attr :type, :any, default: :button
      attr :"--html-attrs", :map, default: %{}

      # Turnstile widget configuration for the (always invisible) widget.
      attr :sitekey, :string, required: true
      attr :action, :string, default: nil
      attr :target, :string, default: nil
      attr :token_key, :string, default: "animexTurnstileToken"
      attr :theme, :string, default: "auto"

      slot :inner_block
      slot :loader
    end
  end
end