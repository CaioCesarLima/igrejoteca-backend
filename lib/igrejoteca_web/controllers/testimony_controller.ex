defmodule IgrejotecaWeb.TestimonyController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.PrayerRequest.Testimonials.Repository
  alias Igrejoteca.PrayerRequest.Testimonials.Testimony

  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, _params) do
    testimonials = Repository.list_testimonials()
    render(conn, "index.json", testimonials: testimonials)
  end

  def create(%{assigns: %{current_user: current_user}} = conn, %{"description" => description}) do
    testimony_params = %{
      "description" => description,
      "owner_id" => current_user
    }
    with {:ok, %Testimony{} = testimony} <- Repository.create_testimony(testimony_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.testimony_path(conn, :show, testimony))
      |> render("show.json", testimony: testimony)
    end
  end

  def show(conn, %{"id" => id}) do
    testimony = Repository.get_testimony!(id)
    render(conn, "show.json", testimony: testimony)
  end

  def update(conn, %{"id" => id, "testimony" => testimony_params}) do
    testimony = Repository.get_testimony!(id)

    with {:ok, %Testimony{} = testimony} <- Repository.update_testimony(testimony, testimony_params) do
      render(conn, "show.json", testimony: testimony)
    end
  end

  def delete(conn, %{"id" => id}) do
    testimony = Repository.get_testimony!(id)

    with {:ok, %Testimony{}} <- Repository.delete_testimony(testimony) do
      send_resp(conn, :no_content, "")
    end
  end
end
