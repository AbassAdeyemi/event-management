defmodule EventManagement.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true }
  schema "events" do
    field :description, :string
    field :title, :string
    field :location, :string
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    field :tags, :string
    field :user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :description, :start_time, :end_time, :location, :tags, :user_id])
    |> validate_required([:title, :description, :start_time, :end_time, :location, :tags, :user_id])
  end
end
