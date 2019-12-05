defmodule Postit.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Postit.Posting.Post
  alias Postit.UserManager.{User, Encryption, AuthToken}

  alias Argon2

  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string, unique: true, null: false
    field :fullname, :string, null: false

    # VIRTUAL FIELDS
    field :plain_text_password, :string, virtual: true

    has_many :posts, Post
    # add the association among the rest of the schema
    has_many :auth_tokens, AuthToken
    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :plain_text_password, :username, :fullname])
    |> validate_required([:email])
    |> validate_length(:plain_text_password, min: 6)
    |> validate_length(:email, min: 3)
    |> unique_constraint(:email)
    |> downcase_email()
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :plain_text_password)

    if password do
      encrypt_password = Encryption.hash_password(password)
      put_change(changeset, :password, encrypt_password)
    else
      changeset
    end
  end

  defp downcase_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end
end
