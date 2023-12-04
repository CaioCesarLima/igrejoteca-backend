defmodule IgrejotecaWeb.UserController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.Accounts.Repository
  alias Igrejoteca.Accounts.User
  alias Igrejoteca.Quiz.Score.Repository, as: ScoreRepository
  alias IgrejotecaWeb.Utils.Response

  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, _params) do
    users = Repository.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Repository.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.auth_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repository.get_user!(id)
    render(conn, "show_rank.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    IO.inspect(user_params)

    user = Repository.get_user!(id)

    with {:ok, %User{} = user} <- Repository.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def incremment_score(%{assigns: %{current_user: current_user}} = conn, _params) do

    score = ScoreRepository.get_score_by_user_id(current_user)
    IO.inspect(score)

    score_params = %{
      "user_id" => current_user,
      "score" => score.score + 10
    }


    with {:ok, _user} <- ScoreRepository.update_score(score, score_params) do
      Response.ok(conn)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repository.get_user!(id)

    with {:ok, %User{}} <- Repository.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
