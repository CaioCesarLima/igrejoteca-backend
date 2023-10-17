defmodule Igrejoteca.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Igrejoteca.Books` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        autor: "some autor",
        category: "some category",
        image: "some image",
        pages: "some pages",
        sinopse: "some sinopse",
        subtitle: "some subtitle",
        title: "some title"
      })
      |> Igrejoteca.Books.create_book()

    book
  end

  @doc """
  Generate a desire.
  """
  def desire_fixture(attrs \\ %{}) do
    {:ok, desire} =
      attrs
      |> Enum.into(%{
        editora: "some editora",
        title: "some title"
      })
      |> Igrejoteca.Books.create_desire()

    desire
  end
end
