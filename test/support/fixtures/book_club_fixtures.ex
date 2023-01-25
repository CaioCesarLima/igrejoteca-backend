defmodule Igrejoteca.BookClubFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Igrejoteca.BookClub` context.
  """

  @doc """
  Generate a club.
  """
  def club_fixture(attrs \\ %{}) do
    {:ok, club} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Igrejoteca.BookClub.create_club()

    club
  end
end
