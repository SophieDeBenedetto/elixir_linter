require IEx;
defmodule ElixirLinter.Store do 
  use GenServer

  def start_link(repo) do
    Agent.start_link(fn -> %{repo_name: repo} end, name: __MODULE__)
  end

  def get_repo(pid) do 
    Agent.get(pid, fn dict -> dict[:repo_name] end)
  end
end