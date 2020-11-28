defmodule Backend.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :points, :integer

      timestamps()
    end
  end
end
