defmodule EventManagement.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias EventManagement.Repo

  alias EventManagement.Events.Event

  @acceptable_event_filters ["location", "tags"]

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events(params) do
    where_query = get_unwanted_keys(params)
    from(Event, where: ^where_query)  |> Repo.all()
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id, user_id), do: Repo.get_by!(Event, [id: id, user_id: user_id])

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end

  def get_event_by_id(id) do
    Repo.get_by!(Event, id: id)
  end

  defp get_unwanted_keys(query_params) do
    kw = Keyword.new()
      map = Map.filter(query_params, fn {key, _value} ->
      Enum.member?(@acceptable_event_filters, key)
    end)

    kw = Enum.reduce(map, kw, fn {key, value}, acc ->
      Keyword.put(acc, String.to_atom(key), value)
    end)

    #  Enum.each(map, fn {key, value} -> Keyword.put(kw, String.to_atom(key), value) end)
    IO.inspect(kw, label: "keyword_list")
    kw
  end
end
