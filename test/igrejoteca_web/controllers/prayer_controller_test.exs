defmodule IgrejotecaWeb.PrayerControllerTest do
  use IgrejotecaWeb.ConnCase

  import Igrejoteca.PrayerRequestFixtures

  alias Igrejoteca.PrayerRequest.Prayer

  @create_attrs %{
    description: "some description"
  }
  @update_attrs %{
    description: "some updated description"
  }
  @invalid_attrs %{description: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all prayers", %{conn: conn} do
      conn = get(conn, Routes.prayer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create prayer" do
    test "renders prayer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.prayer_path(conn, :create), prayer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.prayer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.prayer_path(conn, :create), prayer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update prayer" do
    setup [:create_prayer]

    test "renders prayer when data is valid", %{conn: conn, prayer: %Prayer{id: id} = prayer} do
      conn = put(conn, Routes.prayer_path(conn, :update, prayer), prayer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.prayer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, prayer: prayer} do
      conn = put(conn, Routes.prayer_path(conn, :update, prayer), prayer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete prayer" do
    setup [:create_prayer]

    test "deletes chosen prayer", %{conn: conn, prayer: prayer} do
      conn = delete(conn, Routes.prayer_path(conn, :delete, prayer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.prayer_path(conn, :show, prayer))
      end
    end
  end

  defp create_prayer(_) do
    prayer = prayer_fixture()
    %{prayer: prayer}
  end
end
