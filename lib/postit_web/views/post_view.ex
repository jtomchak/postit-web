defmodule PostitWeb.PostView do
  use PostitWeb, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, PostitWeb.PostView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{"Full Name": user.fullname}
  end

  def render("post.json", %{post: post}) do
  end
end
