defmodule ServerConfigGen.Mixfile do
  use Mix.Project

  def project do
    [app: :server_config_gen,
     version: "0.0.1",
     elixir: "1.0.2",
     deps: deps]
  end

  def application do
    [
      applications: [],
      mod: {ServerConfigGen, []}
    ]
  end

  defp deps do
    [
      {:poison, "~> 1.3.1"},
      {:exfswatch, "~> 0.0.1"}
    ]
  end
end
