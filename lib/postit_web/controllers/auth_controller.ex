defmodule PostitWeb.AuthController do
  use PostitWeb, :controller
  alias PostitWeb.Router.Helpers # what helpers? provides a basepath?

  plug Ueberauth # adding a plug? 

  alias Ueberauth.Strategy.Helpers

  def logout(conn, _params) do
    conn 
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case UserFromAuth.find_or_create(auth) do # handle ok or error from find or create I didn't see us import that ?
      {:ok, user} ->
        conn 
        |> put_flash(:info, "Successfully authenticated as "<> user.name <> ".")
        |> put_session(:current_user, user)
        |> redirect(to: "/")
      {:error, reason} -> 
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end