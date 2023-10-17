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
    IO.inspect(testimony)
    %{
      id: testimony.id,
      description: testimony.description,
      owner: testimony.owner.name
    }
  end
end
