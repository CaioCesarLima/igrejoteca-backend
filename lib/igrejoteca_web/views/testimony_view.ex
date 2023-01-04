defmodule IgrejotecaWeb.TestimonyView do
  use IgrejotecaWeb, :view
  alias IgrejotecaWeb.TestimonyView

  def render("index.json", %{testimonials: testimonials}) do
    %{data: render_many(testimonials, TestimonyView, "testimony.json")}
  end

  def render("show.json", %{testimony: testimony}) do
    %{data: render_one(testimony, TestimonyView, "testimony.json")}
  end

  def render("testimony.json", %{testimony: testimony}) do
    %{
      id: testimony.id,
      description: testimony.description,
      owner_id: testimony.owner_id
    }
  end
end
