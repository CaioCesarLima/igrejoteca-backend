defmodule IgrejotecaWeb.Middlewares.AuthenticationPlug do
    import Plug.Conn

    alias Igrejoteca.Accounts.Guardian
    alias IgrejotecaWeb.Utils.Response

    def init(options),
        do: options

    def call(conn, _options) do
        conn
        |> get_token()
        |> verify_token()
        |> case do
            {:ok, user_id} ->
                conn
                |> assign(:current_user, user_id)
            _unauthorized ->
                conn
        end
    end

    def authenticate(conn, _options) do
        if Map.get(conn.assigns, :current_user) do
            conn
        else
            Response.unauthorized(conn)
        end
    end

    defp get_token(conn) do
        case get_req_header(conn, "authorization") do
            ["Bearer " <> token] -> token
            _ -> nil
        end
    end

    defp verify_token(nil),
        do: {:error, :invalid}

    defp verify_token(token) do
        case Guardian.decode_and_verify(token) do
            {:ok, %{"sub" => id}} -> {:ok, id}
            _ -> {:error, :unauthorized}
        end
    end
end
