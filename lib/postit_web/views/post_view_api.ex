defmodule PostitWeb.API.PostView do
  use PostitWeb, :view
  require Logger

  def render("show.json", %{user: user}) do
    %{
      fullname: user.fullname,
      username: user.username,
      posts: render_many(user.posts, PostitWeb.API.PostView, "post.json")
    }
  end

  def render("user.json", %{user: user}) do
    %{FullName: user.fullname}
  end

  def render("post.json", %{post: post}) do
    %{title: post.title, content: post.content, createdAt: post.inserted_at, slug: post.slug}
  end
end
