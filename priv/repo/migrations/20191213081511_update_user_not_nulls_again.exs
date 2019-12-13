defmodule Postit.Repo.Migrations.UpdateUserNotNullsAgain do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :username, :string, null: true
      modify :fullname, :string, null: true
      modify :email, :string, null: false
    end
  end
end
