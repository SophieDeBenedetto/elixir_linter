# ElixirLinter

## Next Steps

* How to store absolute filepath from root of this directory to /tmp
* configure to run from command line
* understand how to package for inclusion in a larger project (maybe punt until done with next part)


...

* Use credo to lint repo and capture output
* delete repo from tmp

## Bugz!

* Looks like `#fetch_path` fires, then `#lint_repo` before the repo is fully cloned down. Maybe need to use message sending inside `Store.store_filepath`. Send server pid in to `Store.store_filepath` so that Store can `send` message with filepath to Server, triggering server to Lint repo? OR have top-level supervisor maintain all those pids and pass them down? ACTUALLY -- refactor to use Tasks that are synchronous. 
* Why isn't Credo runner working? find where in Credo code base the files from the collection are actually *read*. Maybe `#run` is taking in raw files, not file names?

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

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

