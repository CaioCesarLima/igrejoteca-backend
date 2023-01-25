defmodule Igrejoteca.Quiz.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Igrejoteca.Quiz.Question

  @mandatory_fields [:text, :question_id, :correct]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "answers" do
    field :correct, :boolean, default: false
    field :text, :string
    belongs_to :question, Question

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, @mandatory_fields)
    |> validate_required(@mandatory_fields)
  end
end
