defmodule Igrejoteca.BookClub.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  alias Igrejoteca.BookClub.Post
  alias Igrejoteca.Accounts.User

  @cast_fields [:text, :user_id, :post_id]
  @mandatory_fields [:text]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "comments" do
    field :text, :string
    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, @cast_fields)
    |> validate_required(@mandatory_fields)
  end
end
