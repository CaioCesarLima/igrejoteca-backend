defmodule Igrejoteca.Quiz.Answer do
  use Ecto.Schema
  import Ecto.Changeset


  @mandatory_fields [:text, :question_id, :correct]

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "answers" do
    field :correct, :boolean, default: false
    field :text, :string
    field :question_id, :binary_id
    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, @mandatory_fields)
    |> validate_required(@mandatory_fields)
  end
end
