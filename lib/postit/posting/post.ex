defmodule Postit.Posting.Post do
  use Ecto.Schema
  import Ecto.Changeset
  require Slugger

  alias Postit.UserManager.User

  # TODO: what is `@derive`
  # @derive {Pheonix.Param, key: :slug}

  schema "posts" do
    field :content, :string
    field :title, :string
    field :published, :boolean, default: false
    field :slug, :string, unique: true

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published, :user_id])
    |> validate_required([:content, :user_id])
    |> process_slug
  end

  # Private
  defp process_slug(%Ecto.Changeset{valid?: validity, changes: %{title: title}} = changeset) do
    case validity do
      true -> put_change(changeset, :slug, Slugger.slugify_downcase(title))
      false -> changeset
    end
  end

  defp process_slug(changeset), do: changeset
end
