defmodule Igrejoteca.PrayerRequest.Testimonials.Repository do
  @moduledoc """
  The PrayerRequest context.
  """

  import Ecto.Query, warn: false
  alias Igrejoteca.Repo

  alias Igrejoteca.PrayerRequest.Testimonials.Testimony

  @doc """
  Returns the list of testimonials.

  ## Examples

      iex> list_testimonials()
      [%Testimony{}, ...]

  """
  def list_testimonials do
    Repo.all(Testimony)
  end

  @doc """
  Gets a single testimony.

  Raises `Ecto.NoResultsError` if the Testimony does not exist.

  ## Examples

      iex> get_testimony!(123)
      %Testimony{}

      iex> get_testimony!(456)
      ** (Ecto.NoResultsError)

  """
  def get_testimony!(id), do: Repo.get!(Testimony, id)

  @doc """
  Creates a testimony.

  ## Examples

      iex> create_testimony(%{field: value})
      {:ok, %Testimony{}}

      iex> create_testimony(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_testimony(attrs \\ %{}) do
    %Testimony{}
    |> Testimony.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a testimony.

  ## Examples

      iex> update_testimony(testimony, %{field: new_value})
      {:ok, %Testimony{}}

      iex> update_testimony(testimony, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_testimony(%Testimony{} = testimony, attrs) do
    testimony
    |> Testimony.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a testimony.

  ## Examples

      iex> delete_testimony(testimony)
      {:ok, %Testimony{}}

      iex> delete_testimony(testimony)
      {:error, %Ecto.Changeset{}}

  """
  def delete_testimony(%Testimony{} = testimony) do
    Repo.delete(testimony)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking testimony changes.

  ## Examples

      iex> change_testimony(testimony)
      %Ecto.Changeset{data: %Testimony{}}

  """
  def change_testimony(%Testimony{} = testimony, attrs \\ %{}) do
    Testimony.changeset(testimony, attrs)
  end
end
