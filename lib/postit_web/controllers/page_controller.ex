defmodule PostitWeb.PageController do
  use PostitWeb, :controller
  alias Postit.Posting

  def index(conn, _params) do
    posts = Posting.list_posts_by_updated()
    render(conn, "index.html", posts: posts, current_user: get_session(conn, :current_user))
  end

  def show(conn, _params) do
    render(conn, "show.html")
  end
end
