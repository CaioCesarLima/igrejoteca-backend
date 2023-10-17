defmodule Igrejoteca.Repo.Migrations.CreateDesires do
  use Ecto.Migration

  def change do
    create table(:desires, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :editora, :string

      timestamps()
    end
  end
end
