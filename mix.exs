defmodule ServerConfigGen.Mixfile do
  use Mix.Project

  def project do
    [app: :server_config_gen,
     version: "0.0.1",
     elixir: "1.2.3",
     deps: deps]
  end

  def application do
    [
      applications: [:exfswatch],
    ]
  end

  defp deps do
    [
      {:tomlex, "~> 0.0.4"},
      {:pipe, "~> 0.0.1"},
      {:exfswatch, "~> 0.0.1"},
      {:adt, "~> 0.0.2"},
    ]
  end
end
