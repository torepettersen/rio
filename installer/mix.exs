defmodule Installer.MixProject do
  use Mix.Project

  def project do
    [
      app: :rio_new,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.6", runtime: false},
      {:phx_new, "~> 1.6", runtime: false}
    ]
  end
end
