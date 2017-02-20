require IEx;
defmodule ElixirLinter.Server do
  use GenServer

  def start_link(store_pid, "verbose") do
    repo_name = ElixirLinter.Store.get_repo(store_pid)
    {:ok, task_supervisor_pid} = Task.Supervisor.start_link()
    Agent.start_link(fn -> %{repo_name: repo_name, task_supervisor: task_supervisor_pid} end, name: __MODULE__)
    fetch_repo
    |> lint_repo
    |> process_lint("verbose")
  end

  def process_lint(results, "verbose") do
    IO.puts "INSDIE PROCESS LINT VERBOSE"
    repo_name = get_repo
    worker = get_task_supervisor
    |> Task.Supervisor.async(fn -> 
      ElixirLinter.RepoFetcher.clean_up(repo_name)
    end)
    ElixirLinter.Cli.print_to_command_line(results)
    Task.await(worker)
    results
  end

  def start_link(store_pid) do
    IO.inspect store_pid
    repo_name = List.first(ElixirLinter.Store.get_repo(store_pid))
    {:ok, task_supervisor_pid} = Task.Supervisor.start_link()
    Agent.start_link(fn -> %{repo_name: repo_name, task_supervisor: task_supervisor_pid} end, name: __MODULE__)
    fetch_repo
    |> lint_repo
    |> process_lint
  end

  def process_lint(results) do
    repo_name = get_repo
    worker = get_task_supervisor
    |> Task.Supervisor.async(fn -> 
      ElixirLinter.RepoFetcher.clean_up(repo_name)
    end)
    Task.await(worker)
    results
  end

  def fetch_repo do
    get_task_supervisor
    |> Task.Supervisor.async(fn ->
      get_repo
      |> ElixirLinter.RepoFetcher.fetch
    end)
    |> Task.await
  end

  def lint_repo(filepath) do
    get_task_supervisor
    |> Task.Supervisor.async(fn ->
      ElixirLinter.Linter.lint(filepath)
    end)
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

  def get_repo do 
    Agent.get(__MODULE__, fn dict -> dict[:repo_name] end)
  end

  def get_task_supervisor do 
    Agent.get(__MODULE__, fn dict -> dict[:task_supervisor] end)
  end

end
