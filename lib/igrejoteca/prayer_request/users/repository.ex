defmodule Igrejoteca.PrayerRequest.PrayerUsers.Repository do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias Igrejoteca.Repo

  alias Igrejoteca.PrayerRequest.PrayerUsers

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_users_prayer(prayer_id) do
    query = from pu in PrayerUsers,
      where: pu.prayer_id == ^prayer_id

    Repo.all(query)
  end

  def list_prayers_user(user_id) do
    query = from pu in PrayerUsers,
      where: pu.user_id == ^user_id

    Repo.all(query)
  end

  def add_prayer_to_user(prayer_id, user_id) do
    attrs = %{
      prayer_id: prayer_id,
      user_id: user_id
    }
    %PrayerUsers{}
    |> PrayerUsers.changeset(attrs)
    |> Repo.insert()
  end


  def remove_prayer_to_user(prayer_id, user_id) do
    query = from pu in PrayerUsers,
      where: pu.prayer_id == ^prayer_id,
      where: pu.user_id == ^user_id
    Repo.one(query)
    |> Repo.delete()
  end
end
