defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :duration, :time
      add :completed, :boolean, default: false, null: false
      add :assigned_to, references(:users, on_delete: :nilify_all)

      timestamps()
    end

    create index(:tasks, [:assigned_to])
  end
end
