defmodule IgrejotecaWeb.PostView do
  use IgrejotecaWeb, :view
  alias IgrejotecaWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      text: post.text,
      user: %{
        id: post.user.id,
        name: post.user.name
      },
      club: %{
        name: post.club.name,
        id: post.club.id
      }
    }
  end
end
