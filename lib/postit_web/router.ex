defmodule PostitWeb.Router do
  use PostitWeb, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PostitWeb.Plugs.SetCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PostitWeb do
    pipe_through [:browser, PostitWeb.Plugs.GuestUser]

    get "/", PageController, :index
    resources "/signup", UserController, only: [:create, :new]
    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", PostitWeb do
    pipe_through [:browser, PostitWeb.Plugs.AuthenticateUser]
    get "/", PageController, :index

    get "/logout", SessionController, :delete

    get "/show", PageController, :show
    resources "/events", EventController
    resources "/posts", PostController
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", PostitWeb.API, as: :api do
    pipe_through :api
    get "/users/:username", UserController, :index
    get "/users/:username/posts", PostController, :show
  end
end
