defmodule Igrejoteca.PrayerRequest.PrayerRepository do
  @moduledoc """
  The PrayerRequest context.
  """

  import Ecto.Query, warn: false
  alias Igrejoteca.Repo

  alias Igrejoteca.PrayerRequest.Prayer

  @doc """
  Returns the list of prayers.

  ## Examples

      iex> list_prayers()
      [%Prayer{}, ...]

  """
  def list_prayers do
    Repo.all(Prayer)
  end

  @doc """
  Gets a single prayer.

  Raises `Ecto.NoResultsError` if the Prayer does not exist.

  ## Examples

      iex> get_prayer!(123)
      %Prayer{}

      iex> get_prayer!(456)
      ** (Ecto.NoResultsError)

  """
  # def get_prayer!(id), do: Repo.get!(Prayer, id)
  def get_prayer!(id) do
    Repo.all from p in Prayer,
      where: p.id == ^id,
      preload: [:owner]
  end

  def get_prayer_by_owner!(current_user) do
    # query = from p in Prayer,
    #         where: p.owner_id == ^current_user
    # Repo.all(query, preload)
    Repo.all from p in Prayer,
      where: p.owner_id == ^current_user,
      preload: [:owner]
  end

  @doc """
  Creates a prayer.

  ## Examples

      iex> create_prayer(%{field: value})
      {:ok, %Prayer{}}

      iex> create_prayer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_prayer(attrs \\ %{}) do
    %Prayer{}
    |> Prayer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a prayer.

  ## Examples

      iex> update_prayer(prayer, %{field: new_value})
      {:ok, %Prayer{}}

      iex> update_prayer(prayer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_prayer(%Prayer{} = prayer, attrs) do
    prayer
    |> Prayer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a prayer.

  ## Examples

      iex> delete_prayer(prayer)
      {:ok, %Prayer{}}

      iex> delete_prayer(prayer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_prayer(%Prayer{} = prayer) do
    Repo.delete(prayer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking prayer changes.

  ## Examples

      iex> change_prayer(prayer)
      %Ecto.Changeset{data: %Prayer{}}

  """
  def change_prayer(%Prayer{} = prayer, attrs \\ %{}) do
    Prayer.changeset(prayer, attrs)
  end
end
