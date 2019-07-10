defmodule PostitWeb.Router do
  use PostitWeb, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", PostitWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback # this last item is the function to call? 

  end

  scope "/", PostitWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/logout", AuthController, :logout
    resources "/events", EventController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PostitWeb do
  #   pipe_through :api
  # end
end
