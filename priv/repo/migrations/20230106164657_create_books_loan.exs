defmodule Igrejoteca.Repo.Migrations.CreateBooksLoan do
  use Ecto.Migration

  def change do
    create table(:books_loans, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :book_id, references(:books, on_delete: :delete_all, type: :binary_id)
      add :returned, :boolean, default: false
      timestamps()
    end

    create index(:books_loans, [:user_id])
    create index(:books_loans, [:book_id])
    create unique_index(:books_loans, [:book_id, :user_id])
  end
end
