defmodule Igrejoteca.PrayerRequest.Prayer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Igrejoteca.Accounts.User

  @cast_fields [:description, :is_anonymous, :owner_id, :prayers_count]
  @mandatory_fields [:description, :owner_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "prayers" do
    field :description, :string
    field :is_anonymous, :boolean
    field :prayers_count, :integer
    # field :owner_id, :binary_id
    belongs_to :owner, User
    timestamps()
  end

  @doc false
  def changeset(prayer, attrs) do
    prayer
    |> cast(attrs, @cast_fields)
    |> validate_required(@mandatory_fields)
  end
end
