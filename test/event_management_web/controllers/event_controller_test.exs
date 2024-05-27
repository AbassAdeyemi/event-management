defmodule EventManagementWeb.EventControllerTest do
  use EventManagementWeb.ConnCase

  import EventManagement.EventsFixtures

  alias EventManagement.Events.Event

  @create_attrs %{
    description: "some description",
    title: "some title",
    location: "some location",
    start_time: ~U[2024-05-25 17:45:00Z],
    end_time: ~U[2024-05-25 17:45:00Z],
    tags: "some tags"
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    location: "some updated location",
    start_time: ~U[2024-05-26 17:45:00Z],
    end_time: ~U[2024-05-26 17:45:00Z],
    tags: "some updated tags"
  }
  @invalid_attrs %{description: nil, title: nil, location: nil, start_time: nil, end_time: nil, tags: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all events", %{conn: conn} do
      conn = get(conn, ~p"/api/events")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create event" do
    test "renders event when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/events", event: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/events/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "end_time" => "2024-05-25T17:45:00Z",
               "location" => "some location",
               "start_time" => "2024-05-25T17:45:00Z",
               "tags" => "some tags",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/events", event: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event" do
    setup [:create_event]

    test "renders event when data is valid", %{conn: conn, event: %Event{id: id} = event} do
      conn = put(conn, ~p"/api/events/#{event}", event: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/events/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "end_time" => "2024-05-26T17:45:00Z",
               "location" => "some updated location",
               "start_time" => "2024-05-26T17:45:00Z",
               "tags" => "some updated tags",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, event: event} do
      conn = put(conn, ~p"/api/events/#{event}", event: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete event" do
    setup [:create_event]

    test "deletes chosen event", %{conn: conn, event: event} do
      conn = delete(conn, ~p"/api/events/#{event}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/events/#{event}")
      end
    end
  end

  defp create_event(_) do
    event = event_fixture()
    %{event: event}
  end
end
