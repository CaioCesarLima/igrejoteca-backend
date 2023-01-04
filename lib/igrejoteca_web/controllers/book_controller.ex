defmodule IgrejotecaWeb.BookController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.Books.BookRepository
  alias Igrejoteca.Books.Book
  alias Igrejoteca.Utils.BooksApi
  alias IgrejotecaWeb.Utils.Response
  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, _params) do
    books = BookRepository.list_books()
    render(conn, "index.json", books: books)
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- BookRepository.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_path(conn, :show, book))
      |> render("show.json", book: book)
    end
  end

  def isbn_book(conn, %{"isbn"=> isbn}) do
    {:ok, book_params} =isbn
    |> BooksApi.book_fetch()

    with {:ok, %Book{} = book} <- BookRepository.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_path(conn, :show, book))
      |> render("show.json", book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = BookRepository.get_book!(id)
    render(conn, "show.json", book: book)
  end

  def search_books(conn, %{"search" => search}) do
    books = BookRepository.search_book(search)
    render(conn, "index.json", books: books)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = BookRepository.get_book!(id)

    with {:ok, %Book{} = book} <- BookRepository.update_book(book, book_params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = BookRepository.get_book!(id)

    with {:ok, %Book{}} <- BookRepository.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
