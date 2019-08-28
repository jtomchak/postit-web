defmodule Postit.UserManger.Guardian do
  use Guardian, otp_app: :postit

  alias Postit.UserManger

  # Used to encode the resource into a token
  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  # Used to decode the token and validate / hydrate 
  def resource_from_claims(%{"sub" => id}) do
    case UserManger.get_user(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end
