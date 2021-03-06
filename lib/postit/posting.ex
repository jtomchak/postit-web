defmodule Postit.Posting do
  @moduledoc """
  The Posting context.
  """

  import Ecto.Query, warn: false
  alias Postit.Repo

  alias Postit.Posting.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  retuns all posts by username ordered by latest first

  ## Examples

        iex> list_posts_by_username("Jesse")
        [%Post{}, ...]
  """
  def list_posts_by_username(username) do
    query =
      from p in Post,
        where: p.username == ^username,
        order_by: [desc: :updated_at],
        select: p

    Repo.all(query)
  end

  @doc """
  returns all posts ordered by data published

    ## Examples

      iex> list_posts_by_published()
      [%Post{}, ...]
  """
  def list_posts_by_updated do
    Repo.all(
      from Post,
        order_by: [desc: :updated_at]
    )
  end

  @doc """
  Returns a list of posts by specific user_id

  ## Examples

    iex> get_posts_by(12)
    [%Post{}, ...]
  """
  def get_posts_by(user_id) do
    Repo.all(from Post, where: [user_id: ^user_id], order_by: [desc: :updated_at])
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  def streaks_of_post(user_id) do
    dates =
      from(p in Post,
        distinct: [desc: fragment("?::date", p.published_at)],
        where: p.user_id == ^user_id
      )

    group_dates =
      from(d in subquery(dates),
        select: %{
          rn: row_number() |> over(order_by: fragment("?::date", d.published_at)),
          grp:
            fragment(
              "? + -ROW_NUMBER() OVER (ORDER BY ?) * INTERVAL'1 day'",
              fragment("?::date", d.published_at),
              fragment("?::date", d.published_at)
            ),
          date: fragment("?::date", d.published_at)
        }
      )

    streaks =
      from(g in subquery(group_dates),
        select: %{
          consecutive_days: count(),
          start_date: min(g.date),
          end_date: max(g.date),
          active: fragment("current_date") <= max(g.date) + 1
        },
        group_by: fragment("grp HAVING COUNT(*) > 1"),
        order_by: fragment("1 DESC, 2 DESC")
      )

    Repo.all(streaks)
  end
end
