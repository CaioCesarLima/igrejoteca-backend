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

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> Igrejoteca.BookClub.create_post()

    post
  end

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> Igrejoteca.BookClub.create_comment()

    comment
  end
end
