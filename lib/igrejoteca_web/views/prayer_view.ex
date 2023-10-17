defmodule IgrejotecaWeb.PrayerView do
  use IgrejotecaWeb, :view
  alias IgrejotecaWeb.PrayerView

  def render("index.json", %{prayers: prayers}) do
    %{data: render_many(prayers, PrayerView, "prayer.json")}
  end

  def render("show.json", %{prayer: prayer}) do
    %{data: render_one(prayer, PrayerView, "prayer.json")}
  end

  def render("prayer.json", %{prayer: prayer}) do
    %{
      id: prayer.id,
      description: prayer.description,
      is_anonymous: prayer.is_anonymous,
      like: prayer.prayers_count,
      owner: prayer.owner.name
    }
  end
end
