defmodule PostitWeb.API.UserController do
  use PostitWeb, :controller

  def index(conn, _params) do
    users = []
    json(conn, users)
  end
end
