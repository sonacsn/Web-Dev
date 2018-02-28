defmodule TaskTracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :email, :string, null: false
      modify :name, :string, null: false
    end
    create unique_index(:users, [:email])
  end
end
