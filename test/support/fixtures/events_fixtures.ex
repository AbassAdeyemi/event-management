defmodule EventManagement.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EventManagement.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        description: "some description",
        end_time: ~U[2024-05-25 17:39:00Z],
        location: "some location",
        start_time: ~U[2024-05-25 17:39:00Z],
        tags: "some tags",
        title: "some title"
      })
      |> EventManagement.Events.create_event()

    event
  end

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        description: "some description",
        end_time: ~U[2024-05-25 17:45:00Z],
        location: "some location",
        start_time: ~U[2024-05-25 17:45:00Z],
        tags: "some tags",
        title: "some title"
      })
      |> EventManagement.Events.create_event()

    event
  end
end
