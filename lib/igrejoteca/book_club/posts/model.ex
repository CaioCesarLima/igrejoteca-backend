defmodule Igrejoteca.BookClub.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Igrejoteca.BookClub.Club
  alias Igrejoteca.Accounts.User
  alias Igrejoteca.BookClub.Comment

  @cast_fields [:text, :user_id, :club_id]
  @mandatory_fields [:text]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "posts" do
    field :text, :string
    belongs_to :user, User
    belongs_to :club, Club

    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, @cast_fields)
    |> validate_required(@mandatory_fields)
  end
end
