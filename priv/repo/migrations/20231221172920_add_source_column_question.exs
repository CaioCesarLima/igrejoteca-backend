defmodule Igrejoteca.Repo.Migrations.AddSourceColumnQuestion do
  use Ecto.Migration

  def change do
    alter table("questions") do
      add :source_question, :string, default: ""
    end
  end
end
