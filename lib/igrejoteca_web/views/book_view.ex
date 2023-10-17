defmodule IgrejotecaWeb.BookView do
  use IgrejotecaWeb, :view
  alias IgrejotecaWeb.BookView

  def render("index.json", %{books: books}) do
    %{data: render_many(books, BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    %{
      id: book.id,
      title: book.title,
      subtitle: book.subtitle,
      autor: book.autor,
      category: book.category,
      pages: book.pages,
      status: book.status
    }
  end
end
