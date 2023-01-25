defmodule Igrejoteca.Quiz.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Igrejoteca.Quiz.Answer

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "questions" do
    field :text, :string
    has_many :answers, Answer

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
