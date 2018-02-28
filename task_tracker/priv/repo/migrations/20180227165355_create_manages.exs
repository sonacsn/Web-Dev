defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :started, :boolean, default: false, null: false
    end
  end
end
