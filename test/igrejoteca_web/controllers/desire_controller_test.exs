defmodule IgrejotecaWeb.DesireControllerTest do
  use IgrejotecaWeb.ConnCase

  import Igrejoteca.BooksFixtures

  alias Igrejoteca.Books.Desire

  @create_attrs %{
    editora: "some editora",
    title: "some title"
  }
  @update_attrs %{
    editora: "some updated editora",
    title: "some updated title"
  }
  @invalid_attrs %{editora: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all desires", %{conn: conn} do
      conn = get(conn, Routes.desire_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create desire" do
    test "renders desire when data is valid", %{conn: conn} do
      conn = post(conn, Routes.desire_path(conn, :create), desire: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.desire_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "editora" => "some editora",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.desire_path(conn, :create), desire: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update desire" do
    setup [:create_desire]

    test "renders desire when data is valid", %{conn: conn, desire: %Desire{id: id} = desire} do
      conn = put(conn, Routes.desire_path(conn, :update, desire), desire: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.desire_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "editora" => "some updated editora",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, desire: desire} do
      conn = put(conn, Routes.desire_path(conn, :update, desire), desire: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete desire" do
    setup [:create_desire]

    test "deletes chosen desire", %{conn: conn, desire: desire} do
      conn = delete(conn, Routes.desire_path(conn, :delete, desire))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.desire_path(conn, :show, desire))
      end
    end
  end

  defp create_desire(_) do
    desire = desire_fixture()
    %{desire: desire}
  end
end
