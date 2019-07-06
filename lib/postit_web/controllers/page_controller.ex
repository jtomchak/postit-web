defmodule PostitWeb.PageController do
  use PostitWeb, :controller
  alias Postit.Events # what's an alias for?


  def index(conn, _params) do
  events = Events.list_future_events()
    render(conn, "index.html", events: events) #guessing this binds the events for the template?
  end
end
