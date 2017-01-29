# ElixirLinter

## Next Steps

* How to store absolute filepath from root of this directory to /tmp
* configure to run from command line
* understand how to package for inclusion in a larger project

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

