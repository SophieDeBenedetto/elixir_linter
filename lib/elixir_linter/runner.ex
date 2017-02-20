defmodule ElixirLinter.Runner do 

  def run(repo, "verbose") do 
    ElixirLinter.start("", [repo, "verbose"])
  end

  def run(repo) do
    ElixirLinter.start("", repo) 
  end
end