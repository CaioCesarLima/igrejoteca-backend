defmodule Igrejoteca.BooksTest do
  use Igrejoteca.DataCase

  alias Igrejoteca.Books

  describe "books" do
    alias Igrejoteca.Books.Book

    import Igrejoteca.BooksFixtures

    @invalid_attrs %{autor: nil, category: nil, image: nil, pages: nil, sinopse: nil, subtitle: nil, title: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Books.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Books.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{autor: "some autor", category: "some category", image: "some image", pages: "some pages", sinopse: "some sinopse", subtitle: "some subtitle", title: "some title"}

      assert {:ok, %Book{} = book} = Books.create_book(valid_attrs)
      assert book.autor == "some autor"
      assert book.category == "some category"
      assert book.image == "some image"
      assert book.pages == "some pages"
      assert book.sinopse == "some sinopse"
      assert book.subtitle == "some subtitle"
      assert book.title == "some title"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Books.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{autor: "some updated autor", category: "some updated category", image: "some updated image", pages: "some updated pages", sinopse: "some updated sinopse", subtitle: "some updated subtitle", title: "some updated title"}

      assert {:ok, %Book{} = book} = Books.update_book(book, update_attrs)
      assert book.autor == "some updated autor"
      assert book.category == "some updated category"
      assert book.image == "some updated image"
      assert book.pages == "some updated pages"
      assert book.sinopse == "some updated sinopse"
      assert book.subtitle == "some updated subtitle"
      assert book.title == "some updated title"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Books.update_book(book, @invalid_attrs)
      assert book == Books.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Books.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Books.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Books.change_book(book)
    end
  end

  describe "desires" do
    alias Igrejoteca.Books.Desire

    import Igrejoteca.BooksFixtures

    @invalid_attrs %{editora: nil, title: nil}

    test "list_desires/0 returns all desires" do
      desire = desire_fixture()
      assert Books.list_desires() == [desire]
    end

    test "get_desire!/1 returns the desire with given id" do
      desire = desire_fixture()
      assert Books.get_desire!(desire.id) == desire
    end

    test "create_desire/1 with valid data creates a desire" do
      valid_attrs = %{editora: "some editora", title: "some title"}

      assert {:ok, %Desire{} = desire} = Books.create_desire(valid_attrs)
      assert desire.editora == "some editora"
      assert desire.title == "some title"
    end

    test "create_desire/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Books.create_desire(@invalid_attrs)
    end

    test "update_desire/2 with valid data updates the desire" do
      desire = desire_fixture()
      update_attrs = %{editora: "some updated editora", title: "some updated title"}

      assert {:ok, %Desire{} = desire} = Books.update_desire(desire, update_attrs)
      assert desire.editora == "some updated editora"
      assert desire.title == "some updated title"
    end

    test "update_desire/2 with invalid data returns error changeset" do
      desire = desire_fixture()
      assert {:error, %Ecto.Changeset{}} = Books.update_desire(desire, @invalid_attrs)
      assert desire == Books.get_desire!(desire.id)
    end

    test "delete_desire/1 deletes the desire" do
      desire = desire_fixture()
      assert {:ok, %Desire{}} = Books.delete_desire(desire)
      assert_raise Ecto.NoResultsError, fn -> Books.get_desire!(desire.id) end
    end

    test "change_desire/1 returns a desire changeset" do
      desire = desire_fixture()
      assert %Ecto.Changeset{} = Books.change_desire(desire)
    end
  end
end
