require IEx;
defmodule ElixirLinter.Linter do

  def lint(filepath) do
    {time_load, {source_files, config}} = :timer.tc fn ->
      load_and_validate_files(filepath)
    end

    {time_run, {source_files, config}} =:timer.tc fn ->
      Credo.Check.Runner.run(source_files, config)
    end

    {source_files, config, time_load, time_run}
  end

  def load_and_validate_files(filepath) do
    config = Credo.Config.read_or_default(filepath, nil, true)
      |> Map.merge(%{skipped_checks: [], color: true})
    source_files = list_all(filepath)
      |> Enum.map(&Credo.SourceFile.parse(File.read!(&1), &1))

    {source_files, config}
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
