defmodule ElixirLinter.Supervisor do 
  use Supervisor

  def start_link(repo) do 
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [repo])
    start_workers(sup, repo)
    result
  end

  def start_workers(sup, repo) do 
    {:ok, store} = Supervisor.start_child(sup, worker(ElixirLinter.Store, [repo]))
    Supervisor.start_child(sup, supervisor(ElixirLinter.SubSupervisor, [store]))
  end

  def init(_) do 
    supervise [], strategy: :one_for_one
  end
end