defmodule IgrejotecaWeb.AuthController do
    use IgrejotecaWeb, :controller

    alias Igrejoteca.Accounts.User
    alias Igrejoteca.Accounts.Guardian
    alias IgrejotecaWeb.Resolvers.Accounts.{LoginResolver, SignUpResolver}
    alias IgrejotecaWeb.Utils.Response

    action_fallback IgrejotecaWeb.FallbackController

    def login(conn, %{"identifier" => identifier, "password" => password}) do
        params = %{identifier: identifier, password: password}

        LoginResolver.login(params)
        |> case do
            nil -> Response.unauthorized(conn)
            user ->
                user
                |> gen_token()
                |> case do
                    nil -> Response.forbidden(conn)
                    data -> render(conn, "login.json", auth: data)
                end
        end
    end

    def login(conn, _),
        do: Response.bad_request(conn)

    def signup(conn, %{
        "name" => name,
        "email" => email,
        "password" => password
    }) do
        %{name: name, email: email, password: password}
        |> SignUpResolver.signup()
        |> case do
            {:ok, %User{} = user} ->
                user
                |> gen_token()
                |> case do
                    nil -> Response.forbidden(conn)
                    data -> render(conn, "login.json", auth: data)
                end
            _ -> Response.bad_request(conn)
        end
    end

    def signup(conn, _),
        do: Response.bad_request(conn)

    # defp validate_user(%{is_active: true, is_blocked: false} = user),
    #     do: user

    # defp validate_user(_user),
    #     do: nil

    defp gen_token(nil),
        do: nil

    defp gen_token(user) do

        user
        |> Guardian.encode_and_sign(%{},token_type: "refresh", ttl: {4, :weeks})
        |> IO.inspect(label: "token")
        |> case do
            {:ok, token, _claims} ->
                IO.inspect(token, label: "token")
                %{token: token, user: user}
            _ ->
                IO.inspect(user, label: "nil")
                nil
        end
    end
end
