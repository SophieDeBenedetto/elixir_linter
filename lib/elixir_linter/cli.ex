defmodule ElixirLinter.Cli do
  def main(argv) do
    argv
    |> parse_args
    |> run
  end

  defp parse_args(args) do
    parsed_args = OptionParser.parse(args, switches: [help: :boolean],
                                     aliases: [h: :help])
    case parsed_args do
      {[help: true], _, _} -> :help
      {[lint: repo_name], _, _} -> {:start, repo_name}
      _ -> :help
    end
  end

  defp run(:help) do
    Bunt.puts [:steelblue, """
      Run the Elixir Linter engine from the command line by typing elixir_linter --lint <repo repo>
      where the repo name is formatted like this: 'owner/repo_name`.
    """]
  end

  defp run({:start, repo_name}) do
    ElixirLinter.start("whatever", repo_name)
  end

  def print_to_command_line({source_files, config}) do
    output = Credo.CLI.Output.IssuesByScope
    output.print_before_info(source_files, config)
    output.print_after_info(source_files, config, 0, 0)
  end
end
