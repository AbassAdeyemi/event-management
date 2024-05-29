defmodule EventManagementWeb.ReservationControllerTest do
  use EventManagementWeb.ConnCase

  import EventManagement.ReservationsFixtures

  alias EventManagement.Reservations.Reservation

  @create_attrs %{
    user_id: "some user_id",
    event_id: "some event_id"
  }
  @update_attrs %{
    user_id: "some updated user_id",
    event_id: "some updated event_id"
  }
  @invalid_attrs %{user_id: nil, event_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all reservations", %{conn: conn} do
      conn = get(conn, ~p"/api/reservations")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create reservation" do
    test "renders reservation when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/reservations", reservation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/reservations/#{id}")

      assert %{
               "id" => ^id,
               "event_id" => "some event_id",
               "user_id" => "some user_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/reservations", reservation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update reservation" do
    setup [:create_reservation]

    test "renders reservation when data is valid", %{conn: conn, reservation: %Reservation{id: id} = reservation} do
      conn = put(conn, ~p"/api/reservations/#{reservation}", reservation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/reservations/#{id}")

      assert %{
               "id" => ^id,
               "event_id" => "some updated event_id",
               "user_id" => "some updated user_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, reservation: reservation} do
      conn = put(conn, ~p"/api/reservations/#{reservation}", reservation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete reservation" do
    setup [:create_reservation]

    test "deletes chosen reservation", %{conn: conn, reservation: reservation} do
      conn = delete(conn, ~p"/api/reservations/#{reservation}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/reservations/#{reservation}")
      end
    end
  end

  defp create_reservation(_) do
    reservation = reservation_fixture()
    %{reservation: reservation}
  end
end
