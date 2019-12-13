defmodule Postit.Repo.Migrations.CreateDomains do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :username, :string, null: false
      modify :fullname, :string, null: false
      modify :email, :string, null: true
    end
  end
end
