defmodule Postit.UserManager.AuthToken do
  use Ecto.Schema
  import Ecto.Changeset

  alias Postit.UserManager.{User, Encryption}
  alias Phoenix.Token

  schema "auth_tokens" do
    field :value, :string
    belongs_to :user, User

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(struct, user) do
    struct
    # convert the struct without taking any params
    |> cast(%{}, [])
    |> put_assoc(:user, user)
    |> put_change(:value, generate_token(user))
    |> validate_required([:value, :user])
    |> unique_constraint(:value)
  end

  # generate a random and url-encoded token of given length
  defp generate_token(nil), do: nil

  defp generate_token(user) do
    Token.sign(PostitWeb.Endpoint, "user", user.id)
  end
end
