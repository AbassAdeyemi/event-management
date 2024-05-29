defmodule EventManagement.ReservationsTest do
  use EventManagement.DataCase

  alias EventManagement.Reservations

  describe "reservations" do
    alias EventManagement.Reservations.Reservation

    import EventManagement.ReservationsFixtures

    @invalid_attrs %{}

    test "list_reservations/0 returns all reservations" do
      reservation = reservation_fixture()
      assert Reservations.list_reservations() == [reservation]
    end

    test "get_reservation!/1 returns the reservation with given id" do
      reservation = reservation_fixture()
      assert Reservations.get_reservation!(reservation.id) == reservation
    end

    test "create_reservation/1 with valid data creates a reservation" do
      valid_attrs = %{}

      assert {:ok, %Reservation{} = reservation} = Reservations.create_reservation(valid_attrs)
    end

    test "create_reservation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reservations.create_reservation(@invalid_attrs)
    end

    test "update_reservation/2 with valid data updates the reservation" do
      reservation = reservation_fixture()
      update_attrs = %{}

      assert {:ok, %Reservation{} = reservation} = Reservations.update_reservation(reservation, update_attrs)
    end

    test "update_reservation/2 with invalid data returns error changeset" do
      reservation = reservation_fixture()
      assert {:error, %Ecto.Changeset{}} = Reservations.update_reservation(reservation, @invalid_attrs)
      assert reservation == Reservations.get_reservation!(reservation.id)
    end

    test "delete_reservation/1 deletes the reservation" do
      reservation = reservation_fixture()
      assert {:ok, %Reservation{}} = Reservations.delete_reservation(reservation)
      assert_raise Ecto.NoResultsError, fn -> Reservations.get_reservation!(reservation.id) end
    end

    test "change_reservation/1 returns a reservation changeset" do
      reservation = reservation_fixture()
      assert %Ecto.Changeset{} = Reservations.change_reservation(reservation)
    end
  end

  describe "reservations" do
    alias EventManagement.Reservations.Reservation

    import EventManagement.ReservationsFixtures

    @invalid_attrs %{user_id: nil, event_id: nil}

    test "list_reservations/0 returns all reservations" do
      reservation = reservation_fixture()
      assert Reservations.list_reservations() == [reservation]
    end

    test "get_reservation!/1 returns the reservation with given id" do
      reservation = reservation_fixture()
      assert Reservations.get_reservation!(reservation.id) == reservation
    end

    test "create_reservation/1 with valid data creates a reservation" do
      valid_attrs = %{user_id: "some user_id", event_id: "some event_id"}

      assert {:ok, %Reservation{} = reservation} = Reservations.create_reservation(valid_attrs)
      assert reservation.user_id == "some user_id"
      assert reservation.event_id == "some event_id"
    end

    test "create_reservation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reservations.create_reservation(@invalid_attrs)
    end

    test "update_reservation/2 with valid data updates the reservation" do
      reservation = reservation_fixture()
      update_attrs = %{user_id: "some updated user_id", event_id: "some updated event_id"}

      assert {:ok, %Reservation{} = reservation} = Reservations.update_reservation(reservation, update_attrs)
      assert reservation.user_id == "some updated user_id"
      assert reservation.event_id == "some updated event_id"
    end

    test "update_reservation/2 with invalid data returns error changeset" do
      reservation = reservation_fixture()
      assert {:error, %Ecto.Changeset{}} = Reservations.update_reservation(reservation, @invalid_attrs)
      assert reservation == Reservations.get_reservation!(reservation.id)
    end

    test "delete_reservation/1 deletes the reservation" do
      reservation = reservation_fixture()
      assert {:ok, %Reservation{}} = Reservations.delete_reservation(reservation)
      assert_raise Ecto.NoResultsError, fn -> Reservations.get_reservation!(reservation.id) end
    end

    test "change_reservation/1 returns a reservation changeset" do
      reservation = reservation_fixture()
      assert %Ecto.Changeset{} = Reservations.change_reservation(reservation)
    end
  end
end
