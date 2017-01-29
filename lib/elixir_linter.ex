defmodule ElixirLinter do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _stuff) do
    {:ok, _pid} = ElixirLinter.Supervisor.start_link(["SophieDeBenedetto/jwt-token-auth-sample-api"])
  end
end
