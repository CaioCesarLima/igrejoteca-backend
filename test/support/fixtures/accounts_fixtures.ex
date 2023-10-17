defmodule Igrejoteca.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Igrejoteca.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Igrejoteca.Accounts.create_user()

    user
  end
end
