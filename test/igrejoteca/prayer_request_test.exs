defmodule Igrejoteca.PrayerRequestTest do
  use Igrejoteca.DataCase

  alias Igrejoteca.PrayerRequest

  describe "prayers" do
    alias Igrejoteca.PrayerRequest.Prayer

    import Igrejoteca.PrayerRequestFixtures

    @invalid_attrs %{description: nil}

    test "list_prayers/0 returns all prayers" do
      prayer = prayer_fixture()
      assert PrayerRequest.list_prayers() == [prayer]
    end

    test "get_prayer!/1 returns the prayer with given id" do
      prayer = prayer_fixture()
      assert PrayerRequest.get_prayer!(prayer.id) == prayer
    end

    test "create_prayer/1 with valid data creates a prayer" do
      valid_attrs = %{description: "some description"}

      assert {:ok, %Prayer{} = prayer} = PrayerRequest.create_prayer(valid_attrs)
      assert prayer.description == "some description"
    end

    test "create_prayer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PrayerRequest.create_prayer(@invalid_attrs)
    end

    test "update_prayer/2 with valid data updates the prayer" do
      prayer = prayer_fixture()
      update_attrs = %{description: "some updated description"}

      assert {:ok, %Prayer{} = prayer} = PrayerRequest.update_prayer(prayer, update_attrs)
      assert prayer.description == "some updated description"
    end

    test "update_prayer/2 with invalid data returns error changeset" do
      prayer = prayer_fixture()
      assert {:error, %Ecto.Changeset{}} = PrayerRequest.update_prayer(prayer, @invalid_attrs)
      assert prayer == PrayerRequest.get_prayer!(prayer.id)
    end

    test "delete_prayer/1 deletes the prayer" do
      prayer = prayer_fixture()
      assert {:ok, %Prayer{}} = PrayerRequest.delete_prayer(prayer)
      assert_raise Ecto.NoResultsError, fn -> PrayerRequest.get_prayer!(prayer.id) end
    end

    test "change_prayer/1 returns a prayer changeset" do
      prayer = prayer_fixture()
      assert %Ecto.Changeset{} = PrayerRequest.change_prayer(prayer)
    end
  end

  describe "testimonials" do
    alias Igrejoteca.PrayerRequest.Testimony

    import Igrejoteca.PrayerRequestFixtures

    @invalid_attrs %{description: nil, owner_id: nil}

    test "list_testimonials/0 returns all testimonials" do
      testimony = testimony_fixture()
      assert PrayerRequest.list_testimonials() == [testimony]
    end

    test "get_testimony!/1 returns the testimony with given id" do
      testimony = testimony_fixture()
      assert PrayerRequest.get_testimony!(testimony.id) == testimony
    end

    test "create_testimony/1 with valid data creates a testimony" do
      valid_attrs = %{description: "some description", owner_id: "some owner_id"}

      assert {:ok, %Testimony{} = testimony} = PrayerRequest.create_testimony(valid_attrs)
      assert testimony.description == "some description"
      assert testimony.owner_id == "some owner_id"
    end

    test "create_testimony/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PrayerRequest.create_testimony(@invalid_attrs)
    end

    test "update_testimony/2 with valid data updates the testimony" do
      testimony = testimony_fixture()
      update_attrs = %{description: "some updated description", owner_id: "some updated owner_id"}

      assert {:ok, %Testimony{} = testimony} = PrayerRequest.update_testimony(testimony, update_attrs)
      assert testimony.description == "some updated description"
      assert testimony.owner_id == "some updated owner_id"
    end

    test "update_testimony/2 with invalid data returns error changeset" do
      testimony = testimony_fixture()
      assert {:error, %Ecto.Changeset{}} = PrayerRequest.update_testimony(testimony, @invalid_attrs)
      assert testimony == PrayerRequest.get_testimony!(testimony.id)
    end

    test "delete_testimony/1 deletes the testimony" do
      testimony = testimony_fixture()
      assert {:ok, %Testimony{}} = PrayerRequest.delete_testimony(testimony)
      assert_raise Ecto.NoResultsError, fn -> PrayerRequest.get_testimony!(testimony.id) end
    end

    test "change_testimony/1 returns a testimony changeset" do
      testimony = testimony_fixture()
      assert %Ecto.Changeset{} = PrayerRequest.change_testimony(testimony)
    end
  end
end
