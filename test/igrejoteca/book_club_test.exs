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
end
