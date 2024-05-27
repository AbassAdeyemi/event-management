defmodule EventManagementWeb.Plugs.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :event_management,
  module: EventManagement.Guardian,
  error_handler: EventManagementWeb.AuthErrorHandler

 plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
 plug Guardian.Plug.EnsureAuthenticated
 plug Guardian.Plug.LoadResource, allow_blank: true
end
