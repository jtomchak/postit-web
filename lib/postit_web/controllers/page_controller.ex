defmodule PostitWeb.PageController do
  use PostitWeb, :controller
  require Logger
  alias Postit.Posting




  def index(conn, _params) do
    posts = Posting.list_posts_by_published()
    render(conn, "index.html", posts: posts, current_user: get_session(conn, :current_user))
  end
end

