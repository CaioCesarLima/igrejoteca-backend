defmodule Igrejoteca.Repo.Migrations.CreateUsersPrayers do
  use Ecto.Migration

  def change do
    create table(:prayer_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :prayer_id, references(:prayers, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:prayer_users, [:user_id])
    create index(:prayer_users, [:prayer_id])
    create unique_index(:prayer_users, [:prayer_id, :user_id])
  end
end
