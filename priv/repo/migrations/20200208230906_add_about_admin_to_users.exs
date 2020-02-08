defmodule Postit.Repo.Migrations.AddAboutAdminToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :about, :text
      add :admin, :boolean, default: false
    end
  end
end
