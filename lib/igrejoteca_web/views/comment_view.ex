defmodule IgrejotecaWeb.CommentView do
  use IgrejotecaWeb, :view
  alias IgrejotecaWeb.CommentView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{
      id: comment.id,
      text: comment.text,
      user: %{
        name: comment.user.name,
        id: comment.user.id
      }
    }
  end
end
