defmodule IgrejotecaWeb.TestimonyController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.PrayerRequest.Testimonials.Repository
  alias Igrejoteca.PrayerRequest.Testimonials.Testimony
  alias Igrejoteca.Accounts.Repository, as: UserRepository
  alias IgrejotecaWeb.Utils.Response

  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, _params) do
    testimonials = Repository.list_testimonials()
    render(conn, "index.json", testimonials: testimonials)
  end

  def create(%{assigns: %{current_user: current_user}} = conn, %{"description" => description}) do
    owner = UserRepository.get_user!(current_user)
    |> IO.inspect()
    testimony_params = %{
      "description" => description,
      "owner_id" => current_user,
      "owner" => owner
    }
    with {:ok, %Testimony{} = _testimony} <- Repository.create_testimony(testimony_params) do
      conn
      |> Response.created()
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
