defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    drop constraint(:tasks, "tasks_assigned_to_fkey")
    alter table(:tasks) do
      modify(:assigned_to, references(:users, on_delete: :nilify_all))
    end
  end
end
