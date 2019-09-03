defmodule PostitWeb.PostController do
  use PostitWeb, :controller
  require Logger

  alias Postit.Posting
  alias Postit.Posting.Post

  def index(conn, _params) do
    posts = Posting.get_posts_by(conn.assigns.current_user.id)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Posting.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case post_params
         |> Map.put("user_id", conn.assigns.current_user.id)
         |> Posting.create_post() do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posting.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Posting.get_post!(id)
    changeset = Posting.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posting.get_post!(id)

    case Posting.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posting.get_post!(id)
    {:ok, _post} = Posting.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
