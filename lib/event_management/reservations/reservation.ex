defmodule EventManagement.Reservations.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "reservations" do
    field :user_id, :binary_id
    field :event_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:user_id, :event_id])
    |> validate_required([:user_id, :event_id])
  end
end
