defmodule ElixirLinter.SubSupervisor do 
  use Supervisor 

  def start_link(store_pid) do 
    {:ok, _pid} = Supervisor.start_link(__MODULE__, store_pid)
  end

  def init(store_pid) do 
    child_processes = [worker(ElixirLinter.Server, [store_pid])]
    supervise child_processes, strategy: :one_for_one
  end
end