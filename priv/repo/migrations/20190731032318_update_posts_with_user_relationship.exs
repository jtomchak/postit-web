defmodule Postit.Repo.Migrations.UpdatePostsWithUserRelationship do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :user_id, :string
    end
  create index(:posts, [:user_id])
  end
end
