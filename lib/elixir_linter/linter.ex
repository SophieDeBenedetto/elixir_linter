require IEx;
defmodule ElixirLinter.Linter do 

  def lint(filepath) do 
    IO.puts "INSIDE LINT+++++++++++"
    IO.puts "FILEPATH: #{filepath}"
     # i think this will check for config in the given dir, or use the default. 
    config = Credo.Config.read_or_default(filepath, nil, true)
    files = list_all(filepath)
    IEx.pry
    x = Credo.Check.Runner.run(files, config)
    IEx.pry
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
    [path]
  end

  # def delete_all(list, el) do 
  #   _delete_all(list, el, []) |> Enum.reverse
  # end

  # def _delete_all([head | tail], el, new_list) when head === el do
  #   _delete_all(tail, el, new_list)
  # end


  # def _delete_all([head | tail], el, new_list) do 
  #   _delete_all(tail, el, [head | new_list])
  # end

  # def _delete_all([], _, new_list) do 
  #   new_list
  # end

  # def _clean_up(list) do 
  #   list
  #   |> List.flatten
  #   |> delete_all(nil)
  # end
end
