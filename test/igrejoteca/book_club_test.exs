defmodule Igrejoteca.BookClubTest do
  use Igrejoteca.DataCase

  alias Igrejoteca.BookClub

  describe "clubs" do
    alias Igrejoteca.BookClub.Club

    import Igrejoteca.BookClubFixtures

    @invalid_attrs %{name: nil}

    test "list_clubs/0 returns all clubs" do
      club = club_fixture()
      assert BookClub.list_clubs() == [club]
    end

    test "get_club!/1 returns the club with given id" do
      club = club_fixture()
      assert BookClub.get_club!(club.id) == club
    end

    test "create_club/1 with valid data creates a club" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Club{} = club} = BookClub.create_club(valid_attrs)
      assert club.name == "some name"
    end

    test "create_club/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BookClub.create_club(@invalid_attrs)
    end

    test "update_club/2 with valid data updates the club" do
      club = club_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Club{} = club} = BookClub.update_club(club, update_attrs)
      assert club.name == "some updated name"
    end

    test "update_club/2 with invalid data returns error changeset" do
      club = club_fixture()
      assert {:error, %Ecto.Changeset{}} = BookClub.update_club(club, @invalid_attrs)
      assert club == BookClub.get_club!(club.id)
    end

    test "delete_club/1 deletes the club" do
      club = club_fixture()
      assert {:ok, %Club{}} = BookClub.delete_club(club)
      assert_raise Ecto.NoResultsError, fn -> BookClub.get_club!(club.id) end
    end

    test "change_club/1 returns a club changeset" do
      club = club_fixture()
      assert %Ecto.Changeset{} = BookClub.change_club(club)
    end
  end

  describe "posts" do
    alias Igrejoteca.BookClub.Post

    import Igrejoteca.BookClubFixtures

    @invalid_attrs %{text: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert BookClub.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert BookClub.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{text: "some text"}

      assert {:ok, %Post{} = post} = BookClub.create_post(valid_attrs)
      assert post.text == "some text"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BookClub.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{text: "some updated text"}

      assert {:ok, %Post{} = post} = BookClub.update_post(post, update_attrs)
      assert post.text == "some updated text"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = BookClub.update_post(post, @invalid_attrs)
      assert post == BookClub.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = BookClub.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> BookClub.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = BookClub.change_post(post)
    end
  end

  describe "comments" do
    alias Igrejoteca.BookClub.Comment

    import Igrejoteca.BookClubFixtures

    @invalid_attrs %{text: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert BookClub.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert BookClub.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{text: "some text"}

      assert {:ok, %Comment{} = comment} = BookClub.create_comment(valid_attrs)
      assert comment.text == "some text"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BookClub.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{text: "some updated text"}

      assert {:ok, %Comment{} = comment} = BookClub.update_comment(comment, update_attrs)
      assert comment.text == "some updated text"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = BookClub.update_comment(comment, @invalid_attrs)
      assert comment == BookClub.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = BookClub.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> BookClub.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = BookClub.change_comment(comment)
    end
  end
end
