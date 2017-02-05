require IEx;
defmodule ElixirLinter.Linter do

  def lint(filepath) do
    config = Credo.Config.read_or_default(filepath, nil, true)
    config = Map.merge(config, %{skipped_checks: []})
    source_files = list_all(filepath)
      |> Enum.map(&Credo.SourceFile.parse(File.read!(&1), &1))
    # # config = Credo.Check.Runner.prepare_config(source_files, config)
    {source_files, config} = Credo.Check.Runner.run(source_files, config)
    output = Credo.CLI.Output.IssuesByScope
    output.print_before_info(source_files, config)
    output.print_after_info(source_files, config, 0, 0)


    # i think this will check for config in the given dir, or use the default.
    # config = Credo.Config.read_or_default(filepath, nil, true)
    # list_all(filepath)
    # |> Enum.map(&Credo.SourceFile.parse(File.read!(&1), &1))
    # |> Credo.Check.Runner.run(config)
    # |> IO.inspect

    # EXTRACT ISSUES BY FILENAME
    # result represents a result for a single file analysis
    # file_info = elem(result, 0)
    # file_result = List.first(file_info)
    # file_name = file_result.name
    # file_issues = file_result.issues
  end

  def list_all(filepath) do
    _list_all(filepath)
  end

  defp _list_all(filepath) do
    cond do
      String.contains?(filepath, ".git") -> []
      true -> expand(File.ls(filepath), filepath)
    end
  end

  def expand({:ok, files}, path) do
    files
    |> Enum.flat_map(&_list_all("#{path}/#{&1}"))
  end
  def expand({:error, _}, path) do
    cond do
      String.contains?(path, ".ex") == false -> []
      String.contains?(path, ".exs") == false -> []
      true -> [path]
    end
  end
end
