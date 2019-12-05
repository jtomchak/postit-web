defmodule PostitWeb.UserController do
  use PostitWeb, :controller

  alias Postit.UserManager
  alias Postit.UserManager.{User, TokenAuthentication}

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
        |> redirect(to: page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
