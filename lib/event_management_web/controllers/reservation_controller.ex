defmodule EventManagementWeb.ReservationController do
  use EventManagementWeb, :controller

  alias EventManagementWeb.Plugs.AuthPipeline
  alias EventManagement.Reservations
  alias EventManagement.Reservations.Reservation

  action_fallback EventManagementWeb.FallbackController

  plug AuthPipeline
  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    reservations = Reservations.list_reservations(user.id)
    render(conn, :index, reservations: reservations)
  end

  def create(conn, %{"reservation" => reservation_params}) do
    user = Guardian.Plug.current_resource(conn)
    reservation_params = Map.put(reservation_params, "user_id", user.id)

    case Reservations.create_reservation(reservation_params) do
       {:ok, reservation} ->
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/reservations/#{reservation}")
      |> render(:show, reservation: reservation)
      {:error, msg} ->
        conn
        |> put_status(400)
        |> json(%{error: msg})
    end
  end

  def show(conn, %{"id" => id}) do
    reservation = Reservations.get_reservation!(id)
    render(conn, :show, reservation: reservation)
  end

  def delete(conn, %{"id" => id}) do
    reservation = Reservations.get_reservation!(id)

    with {:ok, %Reservation{}} <- Reservations.delete_reservation(reservation) do
      send_resp(conn, :no_content, "")
    end
  end
end
