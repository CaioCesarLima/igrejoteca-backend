defmodule IgrejotecaWeb.PostController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.BookClub.Posts.Repository
  alias Igrejoteca.BookClub.Post

  action_fallback IgrejotecaWeb.FallbackController


  def index(conn, %{"club_id"=> club_id}) do
    posts = Repository.list_posts_by_club(club_id)
    render(conn, "index.json", posts: posts)
  end

  def index(conn, _params) do
    posts = Repository.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(%{assigns: %{current_user: current_user}} = conn, %{"text" => text, "club_id" => club_id}) do
    post_params = %{
      "text" => text,
      "club_id" => club_id,
      "user_id" => current_user
    }
    with {:ok, %Post{} = post} <- Repository.create_post(post_params) do
      post = Repository.get_post!(post.id)

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Repository.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repository.get_post!(id)

    with {:ok, %Post{} = post} <- Repository.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repository.get_post!(id)

    with {:ok, %Post{}} <- Repository.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
