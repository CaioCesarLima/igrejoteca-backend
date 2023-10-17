defmodule Igrejoteca.Repo.Migrations.CreateTestimonials do
  use Ecto.Migration

  def change do
    create table(:testimonials, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :string
      add :owner_id, references(:users, on_delete: :nilify_all, type: :binary_id)

      timestamps()
    end

    create index(:testimonials, [:owner_id])
  end
end
