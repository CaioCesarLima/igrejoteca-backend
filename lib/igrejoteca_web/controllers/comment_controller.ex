defmodule IgrejotecaWeb.CommentController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.BookClub.Comment.Repository
  alias Igrejoteca.BookClub.Comment

  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, %{"post_id"=>post_id}) do
    comments = Repository.list_comments_by_post(post_id)
    render(conn, "index.json", comments: comments)
  end

  def index(conn, _params) do
    comments = Repository.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(%{assigns: %{current_user: current_user}} = conn, %{"text" => text, "post_id"=> post_id}) do

    comment_params = %{
      "text" => text,
      "post_id" => post_id,
      "user_id" => current_user
    }

    with {:ok, %Comment{} = comment} <- Repository.create_comment(comment_params) do
      comment = Repository.get_comment!(comment.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.comment_path(conn, :show, comment))
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Repository.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Repository.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Repository.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Repository.get_comment!(id)

    with {:ok, %Comment{}} <- Repository.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
