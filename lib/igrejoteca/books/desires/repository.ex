defmodule Igrejoteca.Books.Desires.Repository do
  @moduledoc """
  The Books context.
  """

  import Ecto.Query, warn: false
  alias Igrejoteca.Repo

  alias Igrejoteca.Books.Desire

  @doc """
  Returns the list of desires.

  ## Examples

      iex> list_desires()
      [%Desire{}, ...]

  """
  def list_desires do
    Repo.all(Desire)
  end

  @doc """
  Gets a single desire.

  Raises `Ecto.NoResultsError` if the Desire does not exist.

  ## Examples

      iex> get_desire!(123)
      %Desire{}

      iex> get_desire!(456)
      ** (Ecto.NoResultsError)

  """
  def get_desire!(id), do: Repo.get!(Desire, id)

  @doc """
  Creates a desire.

  ## Examples

      iex> create_desire(%{field: value})
      {:ok, %Desire{}}

      iex> create_desire(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_desire(attrs \\ %{}) do
    %Desire{}
    |> Desire.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a desire.

  ## Examples

      iex> update_desire(desire, %{field: new_value})
      {:ok, %Desire{}}

      iex> update_desire(desire, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_desire(%Desire{} = desire, attrs) do
    desire
    |> Desire.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a desire.

  ## Examples

      iex> delete_desire(desire)
      {:ok, %Desire{}}

      iex> delete_desire(desire)
      {:error, %Ecto.Changeset{}}

  """
  def delete_desire(%Desire{} = desire) do
    Repo.delete(desire)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking desire changes.

  ## Examples

      iex> change_desire(desire)
      %Ecto.Changeset{data: %Desire{}}

  """
  def change_desire(%Desire{} = desire, attrs \\ %{}) do
    Desire.changeset(desire, attrs)
  end
end
