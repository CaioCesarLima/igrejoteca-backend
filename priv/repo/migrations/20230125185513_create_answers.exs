defmodule Igrejoteca.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string
      add :correct, :boolean, default: false, null: false
      add :question_id, references(:questions, on_delete: :nilify_all, type: :binary_id)

      timestamps()
    end
    create index(:answers, [:question_id])
  end
end
