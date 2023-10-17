defmodule Igrejoteca.Repo.Migrations.CreateUserScora do
  use Ecto.Migration

  def change do
    create table(:user_score, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :score, :integer
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      timestamps()
    end

    create index(:user_score, [:user_id])
  end
end
