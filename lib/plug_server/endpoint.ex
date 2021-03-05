defmodule PlugServer.Endpoint do
  use Plug.Router
  require Logger

  # use Plug.Logger
  plug(Plug.Logger)

  # matches routes
  plug(:match)

  # by placing this after the match plug, we parse the request AFTEr the route match
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)

  # dispatches responses
  plug(:dispatch)

  get "/ping" do
    send_resp(conn, 200, "pong!")
  end

  post "/events" do
    Logger.info("POST /Events => custom")

    {status, body} = case conn.body_params do
      %{"events" => events} -> {200, process_events(events)}
      _ -> {422, missing_events()}
    end

    send_resp(conn, status, body)
  end

  defp process_events(events) when is_list(events) do
    # do some processing on a list of events
    Poison.encode!(%{response: "Received Events!"})
  end

  defp process_events(_) do
    Poison.encode!(%{response: "Please send some events"})
  end

  defp missing_events do
    Poison.encode!(%{error: "error"})
  end

  match _ do
    send_resp(conn, 404, "Nothing Here :(")
  end
end
