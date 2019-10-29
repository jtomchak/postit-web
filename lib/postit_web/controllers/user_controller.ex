defmodule PostitWeb.UserController do
  use PostitWeb, :controller

  alias Postit.UserManager
  alias Postit.UserManager.User

  def new(conn, _params) do
    changeset = UserManager.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case UserManager.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Signed up successfully.")
        |> redirect(to: Routes.user_path(conn, :show))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
