defmodule PostitWeb.Plugs.GuestUser do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    if get_session(conn, :current_user_id) do
      conn
      |> redirect(to: PostitWeb.Router.Helpers.page_path(conn, :show))
      |> halt()
    end

    conn
  end
end
