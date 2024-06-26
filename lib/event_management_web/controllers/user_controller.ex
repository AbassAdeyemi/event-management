defmodule EventManagementWeb.UserController do
  use EventManagementWeb, :controller

  alias EventManagement.Accounts
  alias EventManagement.Accounts.User
  alias EventManagement.Guardian

  action_fallback EventManagementWeb.FallbackController

  def register(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case  Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user, %{}, ttl: {30, :day})
        json(conn, %{token: token})

      :error ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid Credentials"})
    end
  end
end
