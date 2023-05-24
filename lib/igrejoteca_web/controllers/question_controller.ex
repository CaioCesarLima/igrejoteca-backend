defmodule IgrejotecaWeb.QuestionController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.Quiz.Questions.Repository
  alias Igrejoteca.Quiz.Question
  alias Igrejoteca.Quiz.Answer
  alias IgrejotecaWeb.Utils.Response

  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, _params) do
    questions = Repository.list_questions()
    render(conn, "index.json", questions: questions)
  end

  def create(conn, %{"question" => question_params, "answers" => answers_params}) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:question, Question.changeset(%Question{}, question_params))
    |> Ecto.Multi.run(:answers, fn %{question: question} ->
      Enum.reduce(answers_params, Ecto.Multi.new(), fn(answer_params, multi) ->
        Ecto.Multi.run(multi, "answer_#{answer_params["text"]}", fn _ ->
          Answer.changeset(%Answer{question_id: question.id}, answer_params)
          |> Repo.insert()
        end)
      end)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{question: question}} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.question_path(conn, :show, question))
        |> render("show.json", question: question)
      {:error, _changes, _repo, _reason} ->
        conn
        |> Response.bad_request()
    end
  end

  def show(conn, %{"id" => id}) do
    question = Repository.get_question!(id)
    render(conn, "show.json", question: question)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Repository.get_question!(id)

    with {:ok, %Question{} = question} <- Repository.update_question(question, question_params) do
      render(conn, "show.json", question: question)
    end
  end


  def delete(conn, %{"id" => id}) do
    question = Repository.get_question!(id)

    with {:ok, %Question{}} <- Repository.delete_question(question) do
      send_resp(conn, :no_content, "")
    end
  end
end
