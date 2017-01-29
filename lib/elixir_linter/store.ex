require IEx;
defmodule ElixirLinter.Store do 
  use GenServer

  def start_link(repo) do
    {:ok, pid} = GenServer.start_link(__MODULE__, repo) 
    IO.inspect pid
    {:ok, pid}
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

  def handle_call(:get_repo, _from, state) do
    IO.puts "INSDIE HANDLE CALL**********"
    IO.inspect state 
    repo = List.last(state)
    {:reply, repo, [repo]}
  end

  def handle_call(:get_filepath, _from, [filepath, repo]) do
    {:reply, filepath, [filepath, repo]}
  end

  def handle_cast({:store_filepath, filepath}, state = [repo]) do
    IO.puts "STATE::::::::"
    IO.inspect state
    IO.puts "UPDATED STATE:::::::"
    IO.inspect [filepath | state]
    {:noreply, [filepath | state]} 
  end
end