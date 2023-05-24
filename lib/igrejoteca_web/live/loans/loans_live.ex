defmodule IgrejotecaWeb.LoansLive do
  use Phoenix.LiveView

  alias Igrejoteca.Books.Loan
  alias Igrejoteca.Accounts.Repository
  alias Igrejoteca.Books.BookRepository


  def mount(_params, _session, socket) do
    loans = get_loans()
    {:ok, assign(socket, loans: loans)}
  end

  defp get_loans() do
    loans = Loan.Repository.list_all()

    loans
    |> Enum.map(fn loan -> book = BookRepository.get_book!(loan.book_id)
     Map.put(loan, :book, book) end)
    |> Enum.map(fn loan -> user = Repository.get_user!(loan.user_id)
    Map.put(loan, :user, user) end)
  end

  def handle_event("delivered", %{"id"=>id}, socket) do
    id
    |> Loan.Repository.get_loan!()
    |> Loan.Repository.delete_loan()

    loans = get_loans()

    socket = socket
    |> assign(:loans, loans)

    {:noreply, socket}

  end
end
