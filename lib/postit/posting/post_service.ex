defmodule Postit.Posting.PostService do
  alias Postit.Codefresh
  alias Postit.Posting.Post
  alias Postit.Repo

  alias Ecto.Multi
  require Logger

  # Can load the user association instead of passing it
  # make sure the ok 200 is coming from trigger_build, not hard coded. 
  def create_post(post_changeset) do
    Multi.new()
    |> Multi.insert(:posts, Post.changeset(%Post{}, post_changeset))
    |> Multi.run(:trigger_build, fn repo, %{posts: posts} ->
      # Now trigger the build
      trigger_build(post_changeset)
      {:ok, posts}
    end)
    |> Repo.transaction()
  end

  defp trigger_build(%{"username" => username}) do
    Codefresh.trigger_build(username)
    {:ok, "success"}
  end
end
