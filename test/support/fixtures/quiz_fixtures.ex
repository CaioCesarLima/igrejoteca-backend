defmodule Igrejoteca.QuizFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Igrejoteca.Quiz` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> Igrejoteca.Quiz.create_question()

    question
  end

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        correct: true,
        text: "some text"
      })
      |> Igrejoteca.Quiz.create_answer()

    answer
  end
end
