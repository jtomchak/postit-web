defmodule PostitWeb.API.PostView do
  use PostitWeb, :view
  import Postit.Markdown
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
    %{
      id: post.id,
      title: post.title,
      content_html: transform_html(post.content),
      createdAt: post.inserted_at,
      publishedAt: post.published_at,
      published: post.published,
      slug: post.slug
    }
  end
end
