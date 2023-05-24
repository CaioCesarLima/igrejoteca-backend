defmodule Igrejoteca.Repo.Migrations.CreateClubUsers do
  use Ecto.Migration

  def change do
    create table(:club_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :club_id, references(:clubs, on_delete: :delete_all, type: :binary_id)
      timestamps()
    end

    create index(:club_users, [:user_id])
    create index(:club_users, [:club_id])
    create unique_index(:club_users, [:club_id, :user_id])
  end
end
