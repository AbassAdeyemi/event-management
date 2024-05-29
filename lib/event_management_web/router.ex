defmodule EventManagementWeb.Router do
  use EventManagementWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug EventManagementWeb.Plugs.AuthPipeline
  end

  scope "/api", EventManagementWeb do
    pipe_through :api
    post "/users/register", UserController, :register
    post "/users/login", UserController, :login

    pipe_through :auth
    resources "/events", EventController,  except: [:new, :edit]

    resources "/reservations", ReservationController, except: [:new, :edit]
  end

end
