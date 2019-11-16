defmodule Postit.Repo.Migrations.UpdatePostsWithTimezone do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :published_at, :utc_datetime_usec
      modify :inserted_at, :utc_datetime_usec
      modify :updated_at, :utc_datetime_usec
    end
  end
end
