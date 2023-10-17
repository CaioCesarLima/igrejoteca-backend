defmodule IgrejotecaWeb.BookController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.Books.BookRepository
  alias Igrejoteca.Books.Book
  alias Igrejoteca.Utils.BooksApi
  alias IgrejotecaWeb.Utils.Response
  alias Igrejoteca.Books.Reserve.Repository, as: ReserveRepository
  alias Igrejoteca.Accounts.Repository, as: UserRepository
  alias IgrejotecaWeb.ReserveView
  alias Igrejoteca.Books.Loan.Repository, as: LoanRepository
  alias IgrejotecaWeb.LoanView

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
    IO.inspect(books)
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

  def create_reserve(%{assigns: %{current_user: current_user}} = conn, %{"book_id" => book_id}) do
    book = BookRepository.get_book!(book_id)
    IO.inspect(book)
    case ReserveRepository.add_reserve_to_book(book_id, current_user) do
      {:ok, _struct} ->
        BookRepository.update_book(book, %{:status=> :reserved})
        Response.ok(conn)
      _ -> Response.bad_request(conn)
    end
  end

  def remove_reserve(conn, %{"reserve_id" => reserve_id}) do
    case ReserveRepository.remove_book_to_reserve(reserve_id) do
      {:ok, _struct} -> Response.ok(conn)
      _ -> Response.bad_request(conn)
    end
  end

  def list_reserves(conn, _params) do
    reserves = ReserveRepository.list_all()
    IO.inspect(reserves, label: "reserva original")
    reserves = reserves
    |> Enum.map(fn reserve -> book = BookRepository.get_book!(reserve.book_id)
     Map.put(reserve, :book, book) end)
    |> Enum.map(fn reserve -> user = UserRepository.get_user!(reserve.user_id)
    Map.put(reserve, :user, user) end)

    Enum.each(reserves, fn reserve -> IO.inspect(reserve.book.title) end)

    conn
      |> put_status(:ok)
      |> put_view(ReserveView)
      |> render("index.json", reserves: reserves)

  end

  def user_reserves(%{assigns: %{current_user: current_user}} = conn, _params) do
    reserves = ReserveRepository.reserves_by_user(current_user)
    IO.inspect(reserves, label: "reserva original")
    reserves = reserves
    |> Enum.map(fn reserve -> book = BookRepository.get_book!(reserve.book_id)
     Map.put(reserve, :book, book) end)
    |> Enum.map(fn reserve -> user = UserRepository.get_user!(reserve.user_id)
    Map.put(reserve, :user, user) end)

    Enum.each(reserves, fn reserve -> IO.inspect(reserve.book.title) end)

    conn
      |> put_status(:ok)
      |> put_view(ReserveView)
      |> render("index.json", reserves: reserves)
  end

  def create_loan(conn, %{"book_id" => book_id, "user_id"=> user_id}) do
    book = BookRepository.get_book!(book_id)
    case LoanRepository.add_loan_to_user(book_id, user_id) do
      {:ok, _struct} ->
        BookRepository.update_book(book, %{:status=> :loaned})
        ReserveRepository.remove_book_to_user_and_book(book_id, user_id)
        Response.ok(conn)
      _ -> Response.bad_request(conn)
    end
  end

  def return_loan(conn, %{"loan_id" => loan_id}) do
    loan = LoanRepository.get_loan!(loan_id)
    LoanRepository.update_loan(loan, %{:returned=> true})
    book = BookRepository.get_book!(loan.book_id)
    BookRepository.update_book(book, %{:status=> :released})
    Response.ok(conn)
  end

  def list_loans(conn, %{"returned" => returned}) do
    IO.inspect(returned)
    loans = case String.to_atom(returned) do
      true -> LoanRepository.list_all_returned()
      false -> LoanRepository. list_all_no_returned()
    end
    loans = loans
    |> Enum.map(fn loan -> book = BookRepository.get_book!(loan.book_id)
     Map.put(loan, :book, book) end)
    |> Enum.map(fn loan -> user = UserRepository.get_user!(loan.user_id)
    Map.put(loan, :user, user) end)
    conn
      |> put_status(:ok)
      |> put_view(LoanView)
      |> render("index.json", loans: loans)

  end

  def list_loans(conn, _params) do
    loans = LoanRepository.list_all()

    loans = loans
    |> Enum.map(fn loan -> book = BookRepository.get_book!(loan.book_id)
     Map.put(loan, :book, book) end)
    |> Enum.map(fn loan -> user = UserRepository.get_user!(loan.user_id)
    Map.put(loan, :user, user) end)
    conn
      |> put_status(:ok)
      |> put_view(LoanView)
      |> render("index.json", loans: loans)

  end


  def user_loans(%{assigns: %{current_user: current_user}} = conn, _params) do
    loans = LoanRepository.loans_by_user(current_user)

    loans = loans
    |> Enum.map(fn loan -> book = BookRepository.get_book!(loan.book_id)
     Map.put(loan, :book, book) end)
    |> Enum.map(fn loan -> user = UserRepository.get_user!(loan.user_id)
    Map.put(loan, :user, user) end)
    conn
      |> put_status(:ok)
      |> put_view(LoanView)
      |> render("index.json", loans: loans)
  end
end
