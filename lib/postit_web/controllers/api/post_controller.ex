defmodule PostitWeb.API.PostController do
  use PostitWeb, :controller
  require Logger

  alias Postit.Posting
  alias Postit.UserManager

  def show(conn, %{"username" => username}) do
    user = UserManager.username_with_posts!(username)

    render(conn, "show.json", user: user)
  end
end
