defmodule Igrejoteca.Books.Desire do
  use Ecto.Schema
  import Ecto.Changeset

  @cast_fields [:editora, :title]
  @mandatory_fields [:title]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "desires" do
    field :editora, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(desire, attrs) do
    desire
    |> cast(attrs, @cast_fields)
    |> validate_required(@mandatory_fields)
  end
end
