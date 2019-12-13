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
    plug :fetch_session
  end

  scope "/", PostitWeb do
    pipe_through [:browser, PostitWeb.Plugs.GuestUser]

    get "/", PageController, :index
    get "/signin/:token", SessionController, :show, as: :signin
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    # resources "/signup", UserController, only: [:create, :new]
    get "/signup/beta", UserController, :beta
    post "/signup/beta", UserController, :beta_create
    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", PostitWeb do
    pipe_through [:browser, PostitWeb.Plugs.AuthenticateUser]

    get "/show", PageController, :show
    resources "/posts", PostController
    get "/account", AccountsController, :index
    get "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", PostitWeb.API, as: :api do
    pipe_through :api
    get "/users/:username", UserController, :index
    get "/users/:username/posts", PostController, :show
  end

  scope "/api/v1", PostitWeb.API, as: :api do
    pipe_through [:api, PostitWeb.Plugs.AuthenticateUser]
    resources "/posts", PostController
  end
end
