defmodule IgrejotecaWeb.QuestionView do
  use IgrejotecaWeb, :view
  alias IgrejotecaWeb.QuestionView

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: render_one(question, QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    if Map.has_key?(question, :answers) do

      %{
        id: question.id,
        text: question.text,
        answers: render_many(Enum.shuffle(question.answers), IgrejotecaWeb.AnswerView, "show.json")
      }
    else
      %{
        id: question.id,
        text: question.text,
      }
    end

  end
end
