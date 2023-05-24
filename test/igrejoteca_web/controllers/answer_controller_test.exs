defmodule IgrejotecaWeb.AnswerControllerTest do
  use IgrejotecaWeb.ConnCase

  import Igrejoteca.QuizFixtures

  alias Igrejoteca.Quiz.Answer

  @create_attrs %{
    correct: true,
    text: "some text"
  }
  @update_attrs %{
    correct: false,
    text: "some updated text"
  }
  @invalid_attrs %{correct: nil, text: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all answers", %{conn: conn} do
      conn = get(conn, Routes.answer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create answer" do
    test "renders answer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.answer_path(conn, :create), answer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.answer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "correct" => true,
               "text" => "some text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.answer_path(conn, :create), answer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update answer" do
    setup [:create_answer]

    test "renders answer when data is valid", %{conn: conn, answer: %Answer{id: id} = answer} do
      conn = put(conn, Routes.answer_path(conn, :update, answer), answer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.answer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "correct" => false,
               "text" => "some updated text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, answer: answer} do
      conn = put(conn, Routes.answer_path(conn, :update, answer), answer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete answer" do
    setup [:create_answer]

    test "deletes chosen answer", %{conn: conn, answer: answer} do
      conn = delete(conn, Routes.answer_path(conn, :delete, answer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.answer_path(conn, :show, answer))
      end
    end
  end

  defp create_answer(_) do
    answer = answer_fixture()
    %{answer: answer}
  end
end
