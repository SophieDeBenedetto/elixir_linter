# ElixirLinter

## Next Steps

* How to store absolute filepath from root of this directory to /tmp
* configure to run from command line
* understand how to package for inclusion in a larger project (maybe punt until done with next part)


...

* format issues for output to terminal -- plug in to existing Credo code for this. pass flags down from `ElixirLinter.start` to output issues or capture them.
* capture list of issue structs


## Bugz!

* Credo not excluding the correct files from linting.

## Notes

* `Linter.lint`

```elixir
# EXTRACT ISSUES BY FILENAME
# result represents a result for a single file analysis
file_info = elem(result, 0)
file_result = List.first(file_info)
file_name = file_result.name
file_issues = file_result.issues
```

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

