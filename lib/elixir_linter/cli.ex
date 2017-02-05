defmodule ElixirLinter.Cli do
  def main(argv) do
    argv
    |> parse_args
    |> run
  end

  def parse_args(args) do
    parsed_args = OptionParser.parse(args, switches: [help: :boolean],
                                     aliases: [h: :help])
    case parsed_args do
      {[help: true], _, _} -> :help
      {[lint: repo_name], _, _} -> {:start, repo_name}
      _ -> :help
    end
  end

  def run(:help) do
    Bunt.puts [:steelblue, """
      Run the Elixir Linter engine from the command line by typing elixir_linter --lint <repo repo>
      where the repo name is formatted like this: 'owner/repo_name`.
    """]
  end

  def run({:start, repo_name}) do
    ElixirLinter.start("whatever", repo_name)
  end
end
