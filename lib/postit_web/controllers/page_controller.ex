defmodule PostitWeb.PageController do
  use PostitWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
