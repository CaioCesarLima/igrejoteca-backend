defmodule Igrejoteca.PrayerRequestFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Igrejoteca.PrayerRequest` context.
  """

  @doc """
  Generate a prayer.
  """
  def prayer_fixture(attrs \\ %{}) do
    {:ok, prayer} =
      attrs
      |> Enum.into(%{
        description: "some description"
      })
      |> Igrejoteca.PrayerRequest.create_prayer()

    prayer
  end

  @doc """
  Generate a testimony.
  """
  def testimony_fixture(attrs \\ %{}) do
    {:ok, testimony} =
      attrs
      |> Enum.into(%{
        description: "some description",
        owner_id: "some owner_id"
      })
      |> Igrejoteca.PrayerRequest.create_testimony()

    testimony
  end
end
