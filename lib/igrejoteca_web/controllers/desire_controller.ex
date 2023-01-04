defmodule IgrejotecaWeb.DesireController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.Books.Desires.Repository
  alias Igrejoteca.Books.Desire

  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, _params) do
    desires = Repository.list_desires()
    render(conn, "index.json", desires: desires)
  end

  def create(conn, %{"desire" => desire_params}) do
    with {:ok, %Desire{} = desire} <- Repository.create_desire(desire_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.desire_path(conn, :show, desire))
      |> render("show.json", desire: desire)
    end
  end

  def show(conn, %{"id" => id}) do
    desire = Repository.get_desire!(id)
    render(conn, "show.json", desire: desire)
  end

  def update(conn, %{"id" => id, "desire" => desire_params}) do
    desire = Repository.get_desire!(id)

    with {:ok, %Desire{} = desire} <- Repository.update_desire(desire, desire_params) do
      render(conn, "show.json", desire: desire)
    end
  end

  def delete(conn, %{"id" => id}) do
    desire = Repository.get_desire!(id)

    with {:ok, %Desire{}} <- Repository.delete_desire(desire) do
      send_resp(conn, :no_content, "")
    end
  end
end
