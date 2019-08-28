defmodule Postit.UserManger.Guardian do
  use Guardian, otp_app: :postit

  alias Postit.UserManger

  def subject_for_token(user, _claims) do
    {:ok, to_string(user_id)}
  end
end
