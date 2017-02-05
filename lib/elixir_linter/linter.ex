require IEx;
defmodule ElixirLinter.Linter do

  def lint(filepath) do
    config = Credo.Config.read_or_default(filepath, nil, true)
      |> Map.merge(%{skipped_checks: [], color: true})
    source_files = list_all(filepath)
      |> Enum.map(&Credo.SourceFile.parse(File.read!(&1), &1))
    Credo.Check.Runner.run(source_files, config)
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

  defp expand({:ok, files}, path) do
    files
    |> Enum.flat_map(&_list_all("#{path}/#{&1}"))
  end

  defp expand({:error, _}, path) do
    collect_file({is_elixir_file?(path), path})
  end

  defp collect_file({true, path}), do: [path]

  defp collect_file({false, path}), do: []

  defp is_elixir_file?(path) do
    String.contains?(path, ".ex") || String.contains?(path, ".exs")
  end
end
