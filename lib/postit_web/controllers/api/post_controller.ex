defmodule PostitWeb.API.PostController do
  use PostitWeb, :controller

  alias Postit.Posting

  def index(conn, %{"username" => params}) do
    users = []
    json(conn, users)
  end
end
