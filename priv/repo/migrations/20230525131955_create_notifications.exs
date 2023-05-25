defmodule Igrejoteca.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nilify_all, type: :binary_id)
      add :token, :string
      add :expiration, :utc_datetime, null: true

      timestamps()
    end

    create index(:notifications, [:user_id])
  end
end
