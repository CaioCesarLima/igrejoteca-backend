defmodule Igrejoteca.BookClub.Club do
  use Ecto.Schema
  import Ecto.Changeset

  @cast_fields [:name, :owner_id, :book_id]
  @mandatory_fields [:name]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "clubs" do
    field :name, :string
    field :owner_id, :binary_id
    field :book_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(club, attrs) do
    club
    |> cast(attrs, @cast_fields)
    |> validate_required(@mandatory_fields)
  end
end
