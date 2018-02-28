defmodule TaskTracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    drop table(:timeblocks)
    create table(:timeblocks) do
      add :start, :time
      add :end, :time
      add :started, :boolean, default: false, null: false
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:timeblocks, [:task_id])
  end
end
