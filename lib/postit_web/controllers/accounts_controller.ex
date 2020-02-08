defmodule PostitWeb.AccountsController do
  use PostitWeb, :controller

  alias Postit.UserManager.{User, TokenAuthentication}
  alias Postit.UserManager
  import Logger

  def index(conn, _params) do
    changeset = UserManager.change_user(%User{})
    render(conn, "edit.html", user: conn.assigns.current_user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    changeset = UserManager.change_user(%User{})
    Logger.info("Account: #{inspect(user_params)}")

    case UserManager.update_user(conn.assigns.current_user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully. 👍")
        |> redirect(to: Routes.accounts_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: conn.assigns.current_user, changeset: changeset)
    end
  end
end
