require IEx;
defmodule ElixirLinter do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, repo_name) do
    # "/SophieDeBenedetto/weather-for-noah-elixir-cli"
    {:ok, _pid} = ElixirLinter.Supervisor.start_link([repo_name])
  end
end
