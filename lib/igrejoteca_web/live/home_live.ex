defmodule IgrejotecaWeb.HomeLive do
  use Phoenix.LiveView

  alias Igrejoteca.Books.Loan
  alias Igrejoteca.Accounts.Repository
  alias Igrejoteca.Books.BookRepository

  def mount(_params, _session, socket) do
    loans = Loan.Repository.list_all()

    loans = loans
    |> Enum.map(fn loan -> book = BookRepository.get_book!(loan.book_id)
     Map.put(loan, :book, book) end)
    |> Enum.map(fn loan -> user = Repository.get_user!(loan.user_id)
    Map.put(loan, :user, user) end)
    {:ok, assign(socket, loans: loans)}
  end

  def handle_event("next", _params, socket) do
    {:noreply, push_redirect(socket, to: "/error")}
  end
end
