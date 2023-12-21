defmodule Igrejoteca.Quiz.Question do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}

  schema "questions" do
    field :text, :string
    field :source_question, :string
    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:text, :source_question])
    |> validate_required([:text])
  end
end
