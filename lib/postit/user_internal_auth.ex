defmodule Postit.UserInternalAuth do
  alias Postit.UserManager.{Encryption, User}
  require Logger

  def login(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))

    case authenticated(user, params["plain_text_password"]) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp authenticated(user, plain_text_password) do
    if user do
      {:ok, authenticated_user} = Encryption.validate_password(user, plain_text_password)
      authenticated_user.email == user.email
    else
      nil
    end
  end

  def signed_in?(conn) do
    conn.assigns[:current_user]
  end
end
