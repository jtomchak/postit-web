defmodule PostitWeb.UserController do
  use PostitWeb, :controller

  alias Postit.UserManager
  alias Postit.UserManager.{User, TokenAuthentication, Domain}

  require Logger

  def new(conn, _params) do
    changeset = UserManager.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case UserManager.create_user(user_params) do
      {:ok, user} ->
        TokenAuthentication.provide_token(user)

        conn
        |> put_flash(:info, "You signed up successfully. Please check your email.")
        |> redirect(to: Routes.user_path(conn, :show))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def beta(conn, _params) do
    # Logger.info("beta user ---->>>>> #{inspect(user_params)}")
    # changeset = User.changeset(%User{}, user_params)
    changeset = UserManager.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def beta_create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    %{"domain" => domain} = user_params
    %{"email" => email} = user_params

    beta_user = Map.put(user_params, "username", domain)
    Logger.info("beta user ---->>>>> #{inspect(beta_user)}")

    case UserManager.create_user(beta_user) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "You're queued and ready to roll. We'll be ready soon!")
        |> redirect(to: Routes.user_path(conn, :beta))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end

    render(conn, "new.html", changeset: changeset)
  end
end
