defmodule Igrejoteca.PrayerRequest.Testimonials.Testimony do
  use Ecto.Schema
  import Ecto.Changeset

  alias Igrejoteca.Accounts.User

  @cast_fields [:description, :owner_id,]
  @mandatory_fields [:description, :owner_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "testimonials" do
    field :description, :string
    belongs_to :owner, User
    timestamps()
  end

  @doc false
  def changeset(testimony, attrs) do
    testimony
    |> cast(attrs, @cast_fields)
    |> validate_required(@mandatory_fields)
  end
end
