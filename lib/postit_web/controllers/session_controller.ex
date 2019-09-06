defmodule PostitWeb.SessionController do
  use PostitWeb, :controller

  alias Postit.UserInternalAuth
  alias Postit.Repo

  def new(conn, _params) do
    render(conn, "new.html")
  end

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"session" => auth_params}) do
    case UserInternalAuth.login(auth_params, Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Signed in successfully Meow")
        |> redirect(to: Routes.page_path(conn, :show))

      :error ->
        conn
        |> put_flash(:error, "Sad trombone, problem with user/password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed out, 👋")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
