defmodule PostitWeb.PageController do
  use PostitWeb, :controller
  require Logger
  alias Postit.Posting

  plug PostitWeb.Plugs.AuthenticateUser


  # def index(conn, _params) do
  # events = Events.list_future_events()
  #   render(conn, "index.html", events: events, current_user: get_session(conn, :current_user)) #guessing this binds the events for the template?
  # end

  def index(conn, _params) do
    posts = Posting.get_posts_by(conn.assigns.current_user.id)
    Logger.info("posts: #{inspect posts}")
    render(conn, "index.html", posts: posts, current_user: get_session(conn, :current_user))
  end
end

