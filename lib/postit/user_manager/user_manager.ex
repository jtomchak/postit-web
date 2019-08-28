alias Argon2

def authenticate_user(user, plain_text_password) do
  query = from u in User, where: u.username == ^username

  case Repo.one(query) do
    nil ->
      Argon2.no_user_verify()
      {:error, :invalid_credentials}

    user ->
      if Argon2.verify_pass(plain_text_password, user.password) do
        {:ok, user}
      else
        {:error, :invalid_credentials}
      end
  end
end
