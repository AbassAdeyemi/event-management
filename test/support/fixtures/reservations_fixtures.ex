defmodule EventManagement.ReservationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EventManagement.Reservations` context.
  """

  @doc """
  Generate a reservation.
  """
  def reservation_fixture(attrs \\ %{}) do
    {:ok, reservation} =
      attrs
      |> Enum.into(%{

      })
      |> EventManagement.Reservations.create_reservation()

    reservation
  end

  @doc """
  Generate a reservation.
  """
  def reservation_fixture(attrs \\ %{}) do
    {:ok, reservation} =
      attrs
      |> Enum.into(%{
        event_id: "some event_id",
        user_id: "some user_id"
      })
      |> EventManagement.Reservations.create_reservation()

    reservation
  end
end
