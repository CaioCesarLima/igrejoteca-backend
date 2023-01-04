defmodule Igrejoteca.Repo.Migrations.DropBooks do
  use Ecto.Migration

  def change do
    drop table("books")
  end
end
