# ElixirLinter

Elixir Linter is an engine for quickly and easily running Credo code quality evaluation against any project!

Learn more about Credo here: https://github.com/rrrene/credo

## Configuration
First, you'll need to configure the application with a GitHub API Key. Set your key in your `config.exs` file like this:

```elixir
config :elixir_linter, github_oauth_token: "xxxx"
```

## Installation

1. Add `elixir_linter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:elixir_linter, "~> 0.1.0"}]
end
```

2. Ensure `elixir_linter` is started before your application:

```elixir
def application do
  [applications: [:elixir_linter]]
end
```

## Usage

Start up the application via 

```elixir
ElixirLinter.Runner.run(repo_name)
```

in which `repo_name` represents the name of a GitHub repo containing a valid Elixir project. The `repo_name` should be in the format `owner/project_name`. 

To output Credo results to the command line, run 

```elixir
ElixirLinter.Runner.run(repo_name, "verbose")
```

