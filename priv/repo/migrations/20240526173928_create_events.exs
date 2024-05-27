defmodule EventManagement.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :string
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :location, :string
      add :tags, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:events, [:user_id])
  end
end
