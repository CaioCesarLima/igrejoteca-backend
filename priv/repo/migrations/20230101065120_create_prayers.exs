defmodule Igrejoteca.Repo.Migrations.CreatePrayers do
  use Ecto.Migration

  def change do
    create table(:prayers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :string
      add :is_anonymous, :boolean, default: false, null: false
      add :owner_id, references(:users, on_delete: :nilify_all, type: :binary_id)
      timestamps()
    end

    create index(:prayers, [:owner_id])
  end
end
