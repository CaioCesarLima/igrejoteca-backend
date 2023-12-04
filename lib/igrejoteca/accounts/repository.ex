defmodule Igrejoteca.Accounts.Repository do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Igrejoteca.Repo

  alias Igrejoteca.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def list_rank do
    from(u in Igrejoteca.Accounts.User,
      join: s in Igrejoteca.Quiz.Score,
      where: s.user_id == u.id,
      order_by: [desc: s.score],
      select: %{user: u, score: s.score},
      limit: 10
    )
    |> Repo.all()
  end

  def get_user!(id) do
    from(u in Igrejoteca.Accounts.User,
      join: s in Igrejoteca.Quiz.Score,
      where: s.user_id == u.id,
      where: u.id == ^id,
      order_by: [desc: s.score],
      select: %{user: u, score: s.score}
    )
    |> Repo.one()
  end
  def get_user_change_password!(id), do: Repo.get(User, id)
  def get_user_by_email(email), do: Repo.get_by(User, email: email)

  def get_user_by_username(username), do: Repo.get_by(User, username: username)


  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    IO.inspect(attrs)
    user
    |> User.changeset(attrs)
    |> Repo.update()
    |> IO.inspect()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
