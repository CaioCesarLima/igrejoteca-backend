defmodule Igrejoteca.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :subtitle, :string
      add :autor, :string
      add :category, :string
      add :pages, :string

      timestamps()
    end
  end
end
