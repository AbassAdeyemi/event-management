defmodule EventManagementWeb.EventController do
  use EventManagementWeb, :controller

  alias EventManagement.Events
  alias EventManagement.Events.Event
  alias EventManagement.Guardian
  alias EventManagementWeb.Plugs.AuthPipeline

  action_fallback EventManagementWeb.FallbackController

  plug AuthPipeline when action in [:show, :update, :delete]
  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    IO.inspect user
    events = Events.list_events(user.id)
    render(conn, :index, events: events)
  end

  def create(conn, %{"event" => event_params}) do
    user = Guardian.Plug.current_resource(conn)
    event_params = Map.put(event_params, "user_id", user.id)

    with {:ok, %Event{} = event} <- Events.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/events/#{event}")
      |> render(:show, event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    event = Events.get_event!(id, user.id)
    render(conn, :show, event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    user = Guardian.Plug.current_resource(conn)
    event = Events.get_event!(id, user.id)

    with {:ok, %Event{} = event} <- Events.update_event(event, event_params) do
      render(conn, :show, event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    event = Events.get_event!(id, user.id)

    with {:ok, %Event{}} <- Events.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
