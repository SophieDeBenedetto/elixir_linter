require IEx;
defmodule ElixirLinter.Server do 
  use GenServer

  def start_link(store_pid) do 
    repo_name = List.first(ElixirLinter.Store.get_repo(store_pid))
    Agent.start_link(fn -> %{store_pid: store_pid, repo_name: repo_name} end, name: __MODULE__)
    
    fetch_repo
    |> lint_repo
  end

  def fetch_repo do 
     Task.async(&ElixirLinter.Server.do_fetch_repo/0)
    |> Task.await
  end

  def do_fetch_repo do 
    Agent.get(__MODULE__, fn dict -> dict[:repo_name] end)
    |> _do_fetch_repo
  end

  def _do_fetch_repo(repo) do 
    Task.async(fn -> ElixirLinter.RepoFetcher.fetch(repo) end)
    |> Task.await
  end

  def lint_repo(filepath) do 
    Task.async(fn -> ElixirLinter.Linter.lint(filepath) end)
    |> Task.await
  end

  def terminate do 
    GenServer.call(__MODULE__, :terminate)
  end

  def handle_call(:terminate, _pid, {repo, store_pid}) do 
    IO.puts "I'm terminating"
    IO.inspect {repo, store_pid}
    :ok
  end

  def format_status(_reason, [_pdict, state]) do 
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end

end
