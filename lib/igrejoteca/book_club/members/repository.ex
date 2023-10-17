defmodule Igrejoteca.BookClub.Member.Repository do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias Igrejoteca.Repo

  alias Igrejoteca.BookClub.Member

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_users_club(club_id) do
    query = from m in Member,
      where: m.club_id == ^club_id

    Repo.all(query)
  end


  def list_clubs_user(user_id) do
    query = from m in Member,
      where: m.user_id == ^user_id

    Repo.all(query)
  end

  def add_club_to_user(club_id, user_id) do
    attrs = %{
      club_id: club_id,
      user_id: user_id
    }
    %Member{}
    |> Member.changeset(attrs)
    |> Repo.insert()
  end


  def remove_club_to_user(club_id, user_id) do
    query = from m in Member,
      where: m.club_id == ^club_id,
      where: m.user_id == ^user_id
    Repo.one(query)
    |> Repo.delete()
  end
end
