defmodule Igrejoteca.Repo.Migrations.UpdateUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :score_quiz, :integer
    end
  end
end
