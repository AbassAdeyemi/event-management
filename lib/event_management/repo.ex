defmodule EventManagement.Repo do
  use Ecto.Repo,
    otp_app: :event_management,
    adapter: Ecto.Adapters.Postgres
end
