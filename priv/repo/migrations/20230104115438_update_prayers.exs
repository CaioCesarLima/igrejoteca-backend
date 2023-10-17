defmodule Igrejoteca.Repo.Migrations.UpdatePrayers do
  use Ecto.Migration

  def change do
    alter table("prayers") do
      add :prayers_count, :integer, default: 0
    end
  end
end
