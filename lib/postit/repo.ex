defmodule Postit.Repo do
  use Ecto.Repo,
    otp_app: :postit,
    adapter: Ecto.Adapters.Postgres
end
