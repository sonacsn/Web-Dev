defmodule TaskTracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    rename table(:timeblocks), :end, to: :end_time
  end
end
