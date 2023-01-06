defmodule Igrejoteca.Books.Loan.Repository do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias Igrejoteca.Repo

  alias Igrejoteca.Books.Loan

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """

  def list_all() do
    Repo.all(Loan)
  end

  def list_all_no_returned() do
    query = from l in Loan,
      where: l.returned == false

    Repo.all(query)
  end

  def list_all_returned() do
    query = from l in Loan,
      where: l.returned == true

    Repo.all(query)
  end


  # def get_prayer_id!(prayer_id) do

  # end

  def loans_by_user(user_id) do
    query = from l in Loan,
      where: l.user_id == ^user_id

    Repo.all(query)
  end

  def add_loan_to_user(book_id, user_id) do
    attrs = %{
      book_id: book_id,
      user_id: user_id
    }
    %Loan{}
    |> Loan.changeset(attrs)
    |> Repo.insert()
  end

end
