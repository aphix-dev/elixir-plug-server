defmodule PlugServer.Application do
  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: PlugServer.Router, options: [port: 9090]}
    ]

    opts = [strategy: :one_for_one, name: PlugServer.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end
end
