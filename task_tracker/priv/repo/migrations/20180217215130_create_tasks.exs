defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    drop table(:tasks)
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text
      add :duration, :time
      add :completed, :boolean, default: false, null: false
      add :assigned_to, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:assigned_to])
  end
end
