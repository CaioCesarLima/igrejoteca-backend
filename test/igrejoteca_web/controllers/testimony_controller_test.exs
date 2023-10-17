defmodule IgrejotecaWeb.TestimonyControllerTest do
  use IgrejotecaWeb.ConnCase

  import Igrejoteca.PrayerRequestFixtures

  alias Igrejoteca.PrayerRequest.Testimony

  @create_attrs %{
    description: "some description",
    owner_id: "some owner_id"
  }
  @update_attrs %{
    description: "some updated description",
    owner_id: "some updated owner_id"
  }
  @invalid_attrs %{description: nil, owner_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all testimonials", %{conn: conn} do
      conn = get(conn, Routes.testimony_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create testimony" do
    test "renders testimony when data is valid", %{conn: conn} do
      conn = post(conn, Routes.testimony_path(conn, :create), testimony: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.testimony_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "owner_id" => "some owner_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.testimony_path(conn, :create), testimony: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update testimony" do
    setup [:create_testimony]

    test "renders testimony when data is valid", %{conn: conn, testimony: %Testimony{id: id} = testimony} do
      conn = put(conn, Routes.testimony_path(conn, :update, testimony), testimony: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.testimony_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "owner_id" => "some updated owner_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, testimony: testimony} do
      conn = put(conn, Routes.testimony_path(conn, :update, testimony), testimony: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete testimony" do
    setup [:create_testimony]

    test "deletes chosen testimony", %{conn: conn, testimony: testimony} do
      conn = delete(conn, Routes.testimony_path(conn, :delete, testimony))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.testimony_path(conn, :show, testimony))
      end
    end
  end

  defp create_testimony(_) do
    testimony = testimony_fixture()
    %{testimony: testimony}
  end
end
