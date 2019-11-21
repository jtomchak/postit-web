defmodule Postit.Repo.Migrations.AddCalendarDatetimeMigratePublishDatetime do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :published_at
      add :published_at, :naive_datetime
    end
  end
end
