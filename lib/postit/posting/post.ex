defmodule Postit.Posting.Post do
  use Ecto.Schema
  import Ecto.Changeset
  require Slugger
  require Logger

  alias Postit.UserManager.User
  @timestamps_opts [type: :utc_datetime_usec]

  # TODO: what is `@derive`
  # @derive {Pheonix.Param, key: :slug}

  schema "posts" do
    field :content, :string
    field :title, :string
    field :published, :boolean, default: false
    field :slug, :string
    field :published_at, :naive_datetime

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published, :user_id, :published_at])
    |> validate_required([:content, :user_id])
    |> process_slug
  end

  # Private
  # defp process_published_at(
  #        %Ecto.Changeset{valid?: validity, changes: %{published: published}} = changeset
  #      ) do
  #   case published do
  #     true -> put_change(changeset, :published_at, DateTime.now())
  #     false -> changeset
  #   end
  # end

  defp process_slug(%Ecto.Changeset{valid?: validity, changes: %{title: title}} = changeset) do
    case validity do
      true -> put_change(changeset, :slug, Slugger.slugify_downcase(title))
      false -> changeset
    end
  end

  defp process_slug(%Ecto.Changeset{valid?: validity, changes: %{content: content}} = changeset) do
    case validity do
      true -> put_change(changeset, :slug, Slugger.slugify_downcase(generate_slug(content)))
      false -> changeset
    end
  end

  defp process_slug(changeset), do: changeset

  # With no title the slug will be the first 3 words of the post
  defp generate_slug(content) do
    content_list = String.split(content)
    Enum.join(Enum.slice(content_list, 0..2), " ")
  end
end
