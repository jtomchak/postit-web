defmodule Postit.UserManager.Domain do
  use Ecto.Schema
  import Ecto.Changeset

  alias Postit.UserManager.User

  schema "domains" do
    field :custom_name, :string
    field :has_custom_name, :boolean, default: false
    field :is_reserved, :boolean, default: false
    field :name, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(domain, attrs) do
    domain
    |> cast(attrs, [:name, :is_reserved, :has_custom_name, :custom_name])
    |> validate_required([:name, :is_reserved, :has_custom_name, :custom_name])
    |> unique_constraint(:name)
  end
end
