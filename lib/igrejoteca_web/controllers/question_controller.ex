defmodule IgrejotecaWeb.QuestionController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.Quiz.Questions.Repository
  alias Igrejoteca.Quiz.Question
  alias Igrejoteca.Quiz.Answers
  alias Igrejoteca.Accounts
  alias IgrejotecaWeb.Utils.Response
  alias Igrejoteca.Quiz.Answers

  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, _params) do
    question = Repository.get_random_question()
    render(conn, "show.json", question: question)
  end



  def create(conn, %{"question" => question_params}) do
    with {:ok, %Question{} = question} <- Repository.create_question(question_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.question_path(conn, :show, question))
      |> render("show.json", question: question)
    end
  end



  def show(conn, %{"id" => _id}) do
    question = Repository.get_random_question()
    answers = Answers.Repository.list_answers_by_question(question.id)
    question = Map.put(question, :answers, answers)
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

  def rank(conn, _params) do
    users = Accounts.Repository.list_rank()

    conn
      |> put_status(:ok)
      |> put_view(IgrejotecaWeb.UserView)
      |> render("index_rank.json", users: users)
  end

  def question_answers(conn, %{"question" => question_params, "answers" => list_answers}) do

    with {:ok, %Question{} = question} <- Repository.create_question(question_params) do
      Enum.each(list_answers, fn answer_params ->
        answer_params = Map.put(answer_params, "question_id", question.id)
        Answers.Repository.create_answer(answer_params) end)

      Response.created(conn)
    end
  end

  def html_test(conn, _params) do
    text(conn, "Hello, World!")
  end
end
