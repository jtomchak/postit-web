defmodule Postit.Repo.Migrations.UpdatePostsFieldsForContent do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :slug, :string, unique: true
      remove :user_id
      modify :content, :text
      add :published, :boolean, default: false, null: false
    end
  end
end
