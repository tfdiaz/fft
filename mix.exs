defmodule Fft.MixProject do
  use Mix.Project

  def project do
    [
      app: :fft,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:complex_num, "~> 1.1"},
      {:math, "~> 0.3.0"}
    ]
  end
end
