defmodule EventManagementWeb.ReservationJSON do
  alias EventManagement.Reservations.Reservation

  @doc """
  Renders a list of reservations.
  """
  def index(%{reservations: reservations}) do
    %{data: for(reservation <- reservations, do: data(reservation))}
  end

  @doc """
  Renders a single reservation.
  """
  def show(%{reservation: reservation}) do
    %{data: data(reservation)}
  end

  defp data(%Reservation{} = reservation) do
    %{
      id: reservation.id,
      user_id: reservation.user_id,
      event_id: reservation.event_id
    }
  end
end
