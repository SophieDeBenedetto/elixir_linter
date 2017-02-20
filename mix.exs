defmodule ElixirLinter.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_linter,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     escript: escript]
  end

  def application do
    [applications: [:logger, :porcelain, :credo]]
  end

  defp deps do
    [
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:porcelain, "~> 2.0"}
    ]
  end

  def escript do
    [main_module: ElixirLinter.Cli]
  end
end
