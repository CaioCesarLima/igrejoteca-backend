defmodule Igrejoteca.Repo.Migrations.CreateClubs do
  use Ecto.Migration

  def change do
    create table(:clubs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :book_id, references(:books, on_delete: :delete_all, type: :binary_id)
      add :owner_id, references(:users, on_delete: :nilify_all, type: :binary_id)
      timestamps()
    end

    create index(:clubs, [:book_id])
    create index(:clubs, [:owner_id])
  end
end
