defmodule IgrejotecaWeb.ClubView do
  use IgrejotecaWeb, :view
  alias IgrejotecaWeb.ClubView

  def render("index.json", %{clubs: clubs}) do
    %{data: render_many(clubs, ClubView, "club.json")}
  end

  def render("show.json", %{club: club}) do
    %{data: render_one(club, ClubView, "club.json")}
  end

  def render("club.json", %{club: club}) do
    %{
      id: club.id,
      name: club.name,
      owner: %{
        id: club.owner.id,
        name: club.owner.name
      },
      book: %{
        name: club.book.title,
        subtitle: club.book.subtitle,
        id: club.book.id
      }
    }
  end
end
