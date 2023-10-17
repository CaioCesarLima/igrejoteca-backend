defmodule Igrejoteca.Repo.Migrations.CreateBooksReserve do
  use Ecto.Migration

  def change do
    create table(:books_reserves, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :book_id, references(:books, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:books_reserves, [:user_id])
    create index(:books_reserves, [:book_id])
    create unique_index(:books_reserves, [:book_id, :user_id])
  end
end
