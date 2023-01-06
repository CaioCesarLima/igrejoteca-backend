defmodule IgrejotecaWeb.ReserveView do
  use IgrejotecaWeb, :view
  alias IgrejotecaWeb.ReserveView

  def render("index.json", %{reserves: reserves}) do
    %{data: render_many(reserves, ReserveView, "reserve.json")}
  end

  def render("show.json", %{reserve: reserve}) do
    %{data: render_one(reserve, ReserveView, "reserve.json")}
  end

  def render("reserve.json", %{reserve: reserve}) do
    %{
      id: reserve.id,
      book: %{
        title: reserve.book.title,
        subtitle: reserve.book.subtitle,
        book_id: reserve.book.id
      },
      user: %{
        name: reserve.user.name,
        email: reserve.user.email,
        user_id: reserve.user.id
      }
    }
  end
end
