defmodule AnimEx.CaptchaTurnstile.MixProject do
  use Mix.Project

  def project do
    [
      app: :animex_captcha_turnstile,
      version: "0.0.1",
      elixir: "~> 1.20.5",
      start_permanent: Mix.env() == :prod,
      compilers: Mix.compilers(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:animex, path: "../animex"}
    ]
  end
end
