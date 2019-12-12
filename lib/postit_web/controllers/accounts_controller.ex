defmodule PostitWeb.AccountsController do
  use PostitWeb, :controller

  alias Postit.UserManager.{User, TokenAuthentication}
  alias Postit.UserManager.Accounts
  import Logger

  def index(conn, _params) do
    render(conn, "index.html", current_user: conn.assigns.current_user)
  end

  def update(conn, %{"id" => id, "current_user" => current_user}) do
    # event = Events.get_event!(id)

    # case Events.update_event(event, account_params) do
    #   {:ok, event} ->
    #     conn
    #     |> put_flash(:info, "Event updated successfully.")

    #   # |> redirect(to: Routes.event_path(conn, :show, event))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, "edit.html", event: event, changeset: changeset)
    # end
  end
end
