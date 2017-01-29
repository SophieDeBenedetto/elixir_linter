require IEx;
defmodule ElixirLinter.Server do 
  use GenServer

  def start_link(store_pid) do 
    {:ok, _pid} = GenServer.start_link(__MODULE__, store_pid, name: __MODULE__)
    fetch_repo
    lint_repo
  end

  def fetch_repo do 
    GenServer.cast(__MODULE__, :fetch_repo)
  end

  def lint_repo do 
    GenServer.call(__MODULE__, :lint_repo)
  end

  def handle_cast(:fetch_repo, {repo, store_pid}) do 
    ElixirLinter.RepoFetcher.fetch(repo)
    |> ElixirLinter.Store.store_filepath(store_pid)
    {:noreply, {repo, store_pid}}
  end

  def handle_call(:lint_repo, _pid, {repo, store_pid}) do 
    ElixirLinter.Store.get_filepath store_pid
    |> ElixirLinter.Linter.lint
    #  what to really return?
    {:reply, "test", {repo, store_pid}}
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

  def init(store_pid) do 
    repo = ElixirLinter.Store.get_repo store_pid
    {:ok, {repo, store_pid}}
  end


end
