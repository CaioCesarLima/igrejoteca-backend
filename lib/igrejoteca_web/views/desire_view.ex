defmodule IgrejotecaWeb.DesireView do
  use IgrejotecaWeb, :view
  alias IgrejotecaWeb.DesireView

  def render("index.json", %{desires: desires}) do
    %{data: render_many(desires, DesireView, "desire.json")}
  end

  def render("show.json", %{desire: desire}) do
    %{data: render_one(desire, DesireView, "desire.json")}
  end

  def render("desire.json", %{desire: desire}) do
    %{
      id: desire.id,
      title: desire.title,
      editora: desire.editora
    }
  end
end
