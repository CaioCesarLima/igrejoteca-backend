defmodule Igrejoteca.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :club_id, references(:clubs, on_delete: :delete_all, type: :binary_id)
      timestamps()
    end

    create index(:posts, [:user_id])
    create index(:posts, [:club_id])
  end
end
