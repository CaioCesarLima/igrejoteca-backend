defmodule Igrejoteca.Books.Reserve do
  use Ecto.Schema
  import Ecto.Changeset

  @mandatory_fields [:user_id, :book_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books_reserves" do
    field :user_id, :binary_id
    field :book_id, :binary_id
    timestamps()
  end

  @doc false
  def changeset(prayer_user, attrs) do
    prayer_user
    |> cast(attrs, @mandatory_fields)
    |> validate_required(@mandatory_fields)
  end
end
