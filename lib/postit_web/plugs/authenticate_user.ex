defmodule PostitWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Postit.UserManager

  def init(opts), do: opts

  @moduledoc """
  Method used to secure an endpoint by ensuring there is a current user from get_session
  """
  def call(conn, _opts) do
    if user_id = get_session(conn, :current_user_id) do
      current_user = UserManager.get_user!(user_id)

      conn
      |> assign(:current_user, current_user)
    else
      conn
      |> redirect(to: "/login")
      |> halt()
    end
  end
end
