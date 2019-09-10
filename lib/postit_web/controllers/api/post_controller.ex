defmodule PostitWeb.API.PostController do
  use PostitWeb, :controller
  require Logger

  alias Postit.Posting
  alias Postit.UserManager

  def index(conn, %{"username" => username}) do
    user = UserManager.username_with_posts(username)
    Logger.info("user is #{inspect(user)}")
    json(conn, user)
  end
end
