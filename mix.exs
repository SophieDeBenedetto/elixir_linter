defmodule ElixirLinter.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_linter,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     escript: escript,
     description: description(), 
     package: package()
    ]
  end

  def application do
    [applications: [:logger, :porcelain, :credo]]
  end

  defp deps do
    [
      {:credo, "~> 0.5"},
      {:porcelain, "~> 2.0"}
    ]
  end

  def escript do
    [main_module: ElixirLinter.Cli]
  end

  defp description do 
    """
    Elixir Linter is an engine for quickly and easily running Credo code quality evaluation against any project! 
    Learn more about Credo here: https://github.com/rrrene/credo
    """
  end

  defp package do
    [
     name: :elixir_linter,
     files: ["lib", "tmp", "mix.exs", "README.md", "LICENSE*"],
     maintainers: ["Sophie DeBenedetto"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/SophieDeBenedetto/elixir_linter"}
    ]
  end
end
