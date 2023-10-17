defmodule Igrejoteca.Quiz.Score do
  use Ecto.Schema
  import Ecto.Changeset


  @mandatory_fields [:score, :user_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "user_score" do
    field :score, :integer
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, @mandatory_fields)
    |> validate_required(@mandatory_fields)
  end
end
