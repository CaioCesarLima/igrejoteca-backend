defmodule Igrejoteca.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset


  @cast_fields [:autor, :category, :pages, :subtitle, :title]
  @mandatory_fields [:title]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "books" do
    field :autor, :string
    field :category, :string
    field :pages, :string
    field :subtitle, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, @cast_fields)
    |> validate_required(@mandatory_fields)
  end
end
