require IEx;
defmodule ElixirLinter.Linter do 

  # def lint(filepath) do 
  #   Credo.Config.read_or_default(filepath, nil, true)
  #   # Credo.Config.read_or_default(nil, true)
  #   # Credo.Check.Runner.run(files, config)
  # end

  def list_all(filepath) do
    _list_all(filepath)
    |> _clean_up
  end

  defp _list_all(filepath) do 
    cond do
      String.contains?(filepath, ".git") -> nil
      true -> expand(File.ls(filepath), filepath)       
    end
  end

  def expand({:ok, files}, path) do
    files
    |> Enum.map(&_list_all("#{path}/#{&1}"))
  end
  def expand({:error, _}, path) do 
    path
  end

  def delete_all(list, el) do 
    _delete_all(list, el, []) |> Enum.reverse
  end

  def _delete_all([head | tail], el, new_list) when head === el do
    _delete_all(tail, el, new_list)
  end


  def _delete_all([head | tail], el, new_list) do 
    _delete_all(tail, el, [head | new_list])
  end

  def _delete_all([], _, new_list) do 
    new_list
  end

  def _clean_up(list) do 
    list
    |> List.flatten
    |> delete_all(nil)
  end
end
