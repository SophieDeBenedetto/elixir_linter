require IEx;
defmodule ElixirLinter do
  use Application

  def start(_type, repo_name) do
    {:ok, _pid} = ElixirLinter.Supervisor.start_link([repo_name])
  end
end
