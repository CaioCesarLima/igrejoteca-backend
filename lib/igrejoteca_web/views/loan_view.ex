defmodule IgrejotecaWeb.LoanView do
  use IgrejotecaWeb, :view
  alias IgrejotecaWeb.LoanView

  def render("index.json", %{loans: loans}) do
    %{data: render_many(loans, LoanView, "loan.json")}
  end

  def render("show.json", %{loan: loan}) do
    %{data: render_one(loan, LoanView, "loan.json")}
  end

  def render("loan.json", %{loan: loan}) do
    %{
      id: loan.id,
      returned: loan.returned,
      loan_day: loan.inserted_at,
      book: %{
        title: loan.book.title,
        subtitle: loan.book.subtitle,
        book_id: loan.book.id
      },
      user: %{
        name: loan.user.name,
        email: loan.user.email,
        book_id: loan.book.id
      }
    }
  end
end
