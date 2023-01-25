defmodule IgrejotecaWeb.ClubController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.BookClub.Clubs.Repository
  alias Igrejoteca.BookClub.Club
  alias Igrejoteca.Books.BookRepository
  alias Igrejoteca.Accounts.Repository, as: UserRepository

  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, _params) do
    clubs = Repository.list_clubs()

    clubs = clubs
    |> Enum.map(fn club -> book = BookRepository.get_book!(club.book_id)
     Map.put(club, :book, book) end)
    |> Enum.map(fn club -> user = UserRepository.get_user!(club.owner_id)
    Map.put(club, :owner, user) end)

  end

  def create(%{assigns: %{current_user: current_user}} = conn, %{"name" => name, "book_id" => book_id}) do
    club_params = %{
      "name"=> name,
      "book_id"=> book_id,
      "owner_id"=> current_user
    }
    with {:ok, %Club{} = club} <- Repository.create_club(club_params) do

      book = BookRepository.get_book!(club.book_id)
      club = Map.put(club, :book, book)
      owner = UserRepository.get_user!(club.owner_id)
      club = Map.put(club, :owner, owner)

      IO.inspect(club)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.club_path(conn, :show, club))
      |> render("show.json", club: club)
    end
  end

  def show(conn, %{"id" => id}) do
    club = Repository.get_club!(id)

    book = BookRepository.get_book!(club.book_id)
    club = Map.put(club, :book, book)
    owner = UserRepository.get_user!(club.owner_id)
    club = Map.put(club, :owner, owner)

    render(conn, "show.json", club: club)
  end

  def update(conn, %{"id" => id, "club" => club_params}) do
    club = Repository.get_club!(id)

    with {:ok, %Club{} = club} <- Repository.update_club(club, club_params) do
      render(conn, "show.json", club: club)
    end
  end

  def delete(conn, %{"id" => id}) do
    club = Repository.get_club!(id)

    with {:ok, %Club{}} <- Repository.delete_club(club) do
      send_resp(conn, :no_content, "")
    end
  end
end
