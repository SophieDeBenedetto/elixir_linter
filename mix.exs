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
    First, you'll need to configure the application with a GitHub API Key. Set your key in your `config.exs` file like this:
    ```
    config :elixir_linter, github_oauth_token: "xxxx"
    ```
    Start up the application via `ElixirLinter.Runner.run(repo_name)`, in which `repo_name` represents the name of a GitHub repo containing a valid Elixir project. 
    The `repo_name` should be in the format `owner/project_name`. 

    To output Credo results to the command line, run `ElixirLinter.Runner.run(repo_name, "verbose")`.
    """
  end

  defp package do
    [
     name: :elixir_linter,
     files: ["lib", "tmp", "mix.exs", "README.md", "readme*", "LICENSE*", "license*"],
     maintainers: ["Sophie DeBenedetto"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/SophieDeBenedetto/elixir_linter"}
    ]
  end
end
