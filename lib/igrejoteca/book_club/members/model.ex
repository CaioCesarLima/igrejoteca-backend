defmodule Igrejoteca.BookClub.Member do
  use Ecto.Schema
  import Ecto.Changeset

  @mandatory_fields [:user_id, :club_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "club_users" do
    field :user_id, :binary_id
    field :club_id, :binary_id
    timestamps()
  end

  @doc false
  def changeset(club_user, attrs) do
    club_user
    |> cast(attrs, @mandatory_fields)
    |> validate_required(@mandatory_fields)
  end
end
