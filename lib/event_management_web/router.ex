defmodule EventManagementWeb.Router do
  use EventManagementWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EventManagementWeb do
    pipe_through :api
    post "/users/register", UserController, :register
    post "/users/login", UserController, :login
  end

end
