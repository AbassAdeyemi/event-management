defmodule EventManagementWeb.AuthErrorHandler do
  import Plug.Conn

  def auth_error(conn, {_type, _reason}, _opts) do
    body = Jason.encode!(%{error: "Unauthorized"})
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:unauthorized, body)
  end
end
