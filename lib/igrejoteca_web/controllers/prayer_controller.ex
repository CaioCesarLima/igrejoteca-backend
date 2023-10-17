defmodule IgrejotecaWeb.PrayerController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.PrayerRequest.PrayerRepository
  alias Igrejoteca.PrayerRequest.Prayer
  alias Igrejoteca.PrayerRequest.PrayerUsers.Repository
  alias IgrejotecaWeb.Utils.Response
  alias IgrejotecaWeb.PrayerView

  action_fallback IgrejotecaWeb.FallbackController

  def index(%{assigns: %{current_user: current_user}} = conn, _params) do
    listPrayers = PrayerRepository.get_prayer_by_owner!(current_user)

    render(conn, "index.json", prayers: listPrayers)
  end

  def get_all_prayers(%{assigns: %{current_user: _current_user}} = conn, _params) do
    listPrayers = PrayerRepository.list_prayers()

    render(conn, "index.json", prayers: listPrayers)
  end

  def create(%{assigns: %{current_user: current_user}} = conn, %{"description" => description, "is_anonymous" => is_anonymous}) do
    prayer_params = %{
      "description" => description,
      "is_anonymous" => is_anonymous,
      "owner_id"=> current_user
    }
    with {:ok, %Prayer{} = prayer} <- PrayerRepository.create_prayer(prayer_params) do
      prayerOne = PrayerRepository.get_prayer!(prayer.id)
      |> List.first()
      IO.inspect(prayerOne)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.prayer_path(conn, :show, prayerOne))
      |> render("show.json", prayer: prayerOne)
    end
  end

  def show(conn, %{"id" => id}) do
    prayer = PrayerRepository.get_prayer!(id)
    |> List.first()
    render(conn, "show.json", prayer: prayer)
  end

  def update(conn, %{"id" => id, "prayer" => prayer_params}) do
    prayer = PrayerRepository.get_prayer!(id)

    with {:ok, %Prayer{} = prayer} <- PrayerRepository.update_prayer(prayer, prayer_params) do
      render(conn, "show.json", prayer: prayer)
    end
  end

  def delete(conn, %{"id" => id}) do
    prayer = PrayerRepository.get_prayer!(id)

    with {:ok, %Prayer{}} <- PrayerRepository.delete_prayer(prayer) do
      send_resp(conn, :no_content, "")
    end
  end

  def add_user(%{assigns: %{current_user: current_user}} = conn, %{"prayer_id" => prayer_id}) do
    prayer = PrayerRepository.get_prayer!(prayer_id) |> List.first()
    PrayerRepository.update_prayer(prayer, %{:prayers_count=> prayer.prayers_count + 1})
    |> IO.inspect(label: "depois do update")
    case Repository.add_prayer_to_user(prayer_id, current_user) do
      {:ok, _struct} -> Response.ok(conn)
      _ -> Response.bad_request(conn)
    end
  end

  def remove_user(%{assigns: %{current_user: current_user}} = conn, %{"prayer_id" => prayer_id}) do
    prayer = PrayerRepository.get_prayer!(prayer_id) |> List.first()
    PrayerRepository.update_prayer(prayer, %{:prayers_count=> prayer.prayers_count - 1})
    |> IO.inspect(label: "depois do update")
    Repository.remove_prayer_to_user(prayer_id, current_user)
    Response.ok(conn)
  end

  def list_prayers_user(%{assigns: %{current_user: current_user}} = conn, _params) do
    listPrayers = Repository.list_prayers_user(current_user)

    prayers = Enum.map(listPrayers, fn relation -> PrayerRepository.get_prayer!(relation.prayer_id) |> List.first() end)
    |> Enum.to_list()

    conn
      |> put_status(:created)
      |> put_view(PrayerView)
      |> render("index.json", prayers: prayers)
  end

end
