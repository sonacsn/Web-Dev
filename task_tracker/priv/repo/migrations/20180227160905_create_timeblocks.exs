defmodule TaskTracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    alter table(:timeblocks) do
      add :started, :boolean, default: false, null: false
    end
  end
end
