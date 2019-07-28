defmodule Postit.ReleaseTasks do

  @start_apps [
    :crypto,
    :ssl,
    :postgrex,
    :ecto
  ]

  def myapp do 
    :postit
  end 

  def repos, do: Application.get_env(myapp(), :ecto_repos, [])

  def migrate do
   {:ok, _} = Application.ensure_all_started(:postit)
    path = Application.app_dir(:postit, "priv/repo/migrations")
    Ecto.Migrator.run(Postit.Repo, path, :up, all: true)
  end
  
end