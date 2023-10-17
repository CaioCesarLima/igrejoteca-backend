defmodule Igrejoteca.Repo.Migrations.UpdateBooks do
  use Ecto.Migration

  def change do
    alter table("books") do
      add :status, :string
    end
  end
end
