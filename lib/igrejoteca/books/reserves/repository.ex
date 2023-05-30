defmodule Igrejoteca.Books.Reserve.Repository do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias Igrejoteca.Repo

  alias Igrejoteca.Books.Reserve

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_users_prayer(prayer_id) do
    query = from pu in Reserve,
      where: pu.prayer_id == ^prayer_id

    Repo.all(query)
  end

  def list_all() do
    Repo.all(Reserve)
  end


  # def get_prayer_id!(prayer_id) do

  # end

  def reserves_by_user(user_id) do
    query = from r in Reserve,
      where: r.user_id == ^user_id

    Repo.all(query)
  end

  def add_reserve_to_book(book_id, user_id) do
    attrs = %{
      book_id: book_id,
      user_id: user_id
    }
    %Reserve{}
    |> Reserve.changeset(attrs)
    |> Repo.insert()
  end


  def remove_book_to_reserve(reserve_id) do
    Repo.get!(Reserve, reserve_id)
    |> Repo.delete()
  end

  def remove_book_to_user_and_book(book_id, user_id) do
    from(Reserve)
    |> where([r], r.book_id == ^book_id and r.user_id == ^user_id)
    |> delete()
    |> Repo.delete_all()
  end
end
