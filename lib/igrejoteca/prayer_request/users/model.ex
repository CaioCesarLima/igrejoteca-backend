defmodule Igrejoteca.PrayerRequest.PrayerUsers do
  use Ecto.Schema
  import Ecto.Changeset

  @mandatory_fields [:user_id, :prayer_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "prayer_users" do
    field :user_id, :binary_id
    field :prayer_id, :binary_id
    timestamps()
  end

  @doc false
  def changeset(prayer_user, attrs) do
    prayer_user
    |> cast(attrs, @mandatory_fields)
    |> validate_required(@mandatory_fields)
  end
end
