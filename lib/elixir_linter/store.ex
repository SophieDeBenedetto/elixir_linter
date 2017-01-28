defmodule ElixirLinter.Store do 
  use GenServer

  def start_link(repo) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [repo]) 
  end

  def get_repo(pid) do 
    GenServer.call pid, :get_repo
  end

  def store_filepath(filepath, pid) do 
    GenServer.cast(pid, {:store_filepath, filepath})
  end

  def get_filepath(pid) do 
    GenServer.call pid, :get_filepath
  end

  def handle_call(:get_repo, _from, [repo | tail]) do 
    {:reply, repo}
  end

  def handle_call(:get_filepath, _from, [repo, filepath]) do 
    {:reply, filepath}
  end

  def handle_cast({:store_filepath, filepath}, _current_state) do
    {:norepy, [repo, filepath]} 
  end
end