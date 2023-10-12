defmodule IgrejotecaWeb.AnswerController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.Quiz.Answers.Repository
  alias Igrejoteca.Quiz.Answer
  alias IgrejotecaWeb.Utils.Response

  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, _params) do
    answers = Repository.list_answers()
    render(conn, "index.json", answers: answers)
  end

  def answers_question(conn, %{"question_id" => question_id}) do
    answers = Repository.list_answers_by_question(question_id)
    render(conn, "index.json", answers: answers)
  end

  def create(conn, %{"answers" => list_answers}) do

    Enum.each(list_answers, fn answer_params ->
      Repository.create_answer(answer_params) end)

    Response.ok(conn)

  end

  def show(conn, %{"id" => id}) do
    answer = Repository.get_answer!(id)
    render(conn, "show.json", answer: answer)
  end

  def update(conn, %{"id" => id, "answer" => answer_params}) do
    answer = Repository.get_answer!(id)

    with {:ok, %Answer{} = answer} <- Repository.update_answer(answer, answer_params) do
      render(conn, "show.json", answer: answer)
    end
  end

  def delete(conn, %{"id" => id}) do
    answer = Repository.get_answer!(id)

    with {:ok, %Answer{}} <- Repository.delete_answer(answer) do
      send_resp(conn, :no_content, "")
    end
  end
end
