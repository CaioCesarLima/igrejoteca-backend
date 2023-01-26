defmodule IgrejotecaWeb.ClubController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.BookClub.Clubs.Repository
  alias Igrejoteca.BookClub.Club
  alias Igrejoteca.Books.BookRepository
  alias Igrejoteca.Accounts.Repository, as: UserRepository
  alias Igrejoteca.BookClub.Member.Repository, as: MemberRepository
  alias IgrejotecaWeb.UserView

  alias IgrejotecaWeb.ClubView

  action_fallback IgrejotecaWeb.FallbackController

  def index(conn, _params) do
    clubs = Repository.list_clubs()

    clubs = clubs
    |> Enum.map(fn club -> book = BookRepository.get_book!(club.book_id)
     Map.put(club, :book, book) end)
    |> Enum.map(fn club -> user = UserRepository.get_user!(club.owner_id)
    Map.put(club, :owner, user) end)

    render(conn, "index.json", clubs: clubs)
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

  def add_member(%{assigns: %{current_user: current_user}} = conn, %{"club_id" => club_id}) do
    with {:ok, _club} <- MemberRepository.add_club_to_user(club_id, current_user) do
      send_resp(conn, :ok, "")
    end
  end

  def list_clubs(%{assigns: %{current_user: current_user}} = conn, _params) do
    clubs = MemberRepository.list_clubs_user(current_user)
    clubs = clubs
    |> Enum.map(fn club -> get_club_information(club) end)

    IO.inspect(clubs)


    conn
      |> put_status(:ok)
      |> put_view(ClubView)
      |> render("index.json", clubs: clubs)

  end

  def list_members(conn, %{"club_id" => club_id}) do
    IO.inspect(club_id)
    clubs = MemberRepository.list_users_club(club_id)
    users = clubs
    |> Enum.map(fn club -> UserRepository.get_user!(club.user_id) end)

    IO.inspect(users)


    conn
      |> put_status(:ok)
      |> put_view(UserView)
      |> render("index.json", users: users)

  end
  # end
  defp get_club_information(relation) do
      club = Repository.get_club!(relation.club_id)
      relation = Map.put(relation, :club, club)
      book = BookRepository.get_book!(relation.club.book_id)
      relation_book = Map.put(relation.club, :book, book)
      relation = Map.put(relation, :club, relation_book)
      owner = UserRepository.get_user!(relation.club.owner_id)
      Map.put(relation.club, :owner, owner)
  end
end
