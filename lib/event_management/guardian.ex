defmodule EventManagement.Guardian do
  use Guardian, otp_app: :event_management

  alias EventManagement.Accounts
  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = Accounts.get_user!(id)
    {:ok, user}
  end
end
