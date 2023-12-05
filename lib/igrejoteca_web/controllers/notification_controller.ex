defmodule IgrejotecaWeb.NotificationController do
  use IgrejotecaWeb, :controller

  alias Igrejoteca.Accounts.Notification.Repository
  alias Igrejoteca.Accounts.Notification
  alias IgrejotecaWeb.Utils.Response
  alias Igrejoteca.Utils.HttpPoison
  alias Igrejoteca.Accounts

  action_fallback SAMWeb.FallbackController

  def index(conn, _params) do
    notifications = Repository.list_notifications()
    render(conn, "index.json", notifications: notifications)
  end

  def create(%{assigns: %{current_user: current_user}} = conn, %{"token" => token}) do
    notification_params = %{
      user_id: current_user,
      token: token
    }
    with {:ok, %Notification{} = _notification} <- Repository.create_notification(notification_params) do
      # conn
      # |> put_status(:created)
      # |> put_resp_header("location", Routes.notification_path(conn, :show, notification))
      # |> render("show.json", notification: notification)


      Response.created(conn)
    else
      :error -> Response.bad_request(conn)
      _ -> Response.bad_request(conn)
    end
  end

  def show(conn, %{"id" => id}) do
    notification = Repository.get_notification!(id)
    render(conn, "show.json", notification: notification)
  end

  def update(conn, %{"id" => id, "notification" => notification_params}) do
    notification = Repository.get_notification!(id)

    with {:ok, %Notification{} = notification} <- Repository.update_notification(notification, notification_params) do
      render(conn, "show.json", notification: notification)
    end
  end

  def delete(conn, %{"id" => token}) do
    notification = Repository.get_by_token!(token)
    |> List.first()

    with {:ok, %Notification{}} <- Repository.delete_notification(notification) do
      send_resp(conn, :no_content, "")
    end
  end

  def trigger_notification(conn,  %{"user_id" => user_id, "message" => message, "title" => title}) do
    tokens  =  Repository.get_by_user!(user_id)
    Enum.each(tokens, fn x -> IO.inspect(x.token) end)
    Enum.each(tokens, fn x -> HttpPoison.push_notification(x.token, message, title) end)

    Response.created(conn)
  end

  def trigger_notification_intern(%{"user_id" => user_id, "message" => message, "title" => title}) do
    tokens  =  Repository.get_by_user!(user_id)
    Enum.each(tokens, fn x -> IO.inspect(x.token) end)
    Enum.each(tokens, fn x -> HttpPoison.push_notification(x.token, message, title) end)
  end

  def trigger_notification_intern_all(%{"message" => message, "title" => title}) do
    tokens  =  Repository.list_notifications()
    Enum.each(tokens, fn x -> IO.inspect(x.token) end)
    Enum.each(tokens, fn x -> HttpPoison.push_notification(x.token, message, title) end)
  end

  def send_notification(conn,  %{"message" => message, "title" => title}) do

    users  =  Accounts.Repository.list_users()
    Enum.each(users, fn user -> trigger_notification_intern(%{"user_id" => user.id, "message" => message, "title" => title}) end)

    Response.created(conn)
  end
end
