defmodule Igrejoteca.QuizTest do
  use Igrejoteca.DataCase

  alias Igrejoteca.Quiz

  describe "questions" do
    alias Igrejoteca.Quiz.Question

    import Igrejoteca.QuizFixtures

    @invalid_attrs %{text: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Quiz.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Quiz.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{text: "some text"}

      assert {:ok, %Question{} = question} = Quiz.create_question(valid_attrs)
      assert question.text == "some text"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{text: "some updated text"}

      assert {:ok, %Question{} = question} = Quiz.update_question(question, update_attrs)
      assert question.text == "some updated text"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_question(question, @invalid_attrs)
      assert question == Quiz.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Quiz.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Quiz.change_question(question)
    end
  end

  describe "answers" do
    alias Igrejoteca.Quiz.Answer

    import Igrejoteca.QuizFixtures

    @invalid_attrs %{correct: nil, text: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Quiz.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Quiz.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      valid_attrs = %{correct: true, text: "some text"}

      assert {:ok, %Answer{} = answer} = Quiz.create_answer(valid_attrs)
      assert answer.correct == true
      assert answer.text == "some text"
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{correct: false, text: "some updated text"}

      assert {:ok, %Answer{} = answer} = Quiz.update_answer(answer, update_attrs)
      assert answer.correct == false
      assert answer.text == "some updated text"
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_answer(answer, @invalid_attrs)
      assert answer == Quiz.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Quiz.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Quiz.change_answer(answer)
    end
  end
end
