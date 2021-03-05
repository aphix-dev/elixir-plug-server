defmodule PlugServer.Application do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: PlugServer.Endpoint,
        options: [port: 9090]
      )
    ]

    opts = [strategy: :one_for_one, name: PlugServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
