defmodule IgrejotecaWeb.AuthController do
    use IgrejotecaWeb, :controller

    alias Igrejoteca.Accounts.User
    alias Igrejoteca.Accounts.Guardian
    alias IgrejotecaWeb.Resolvers.Accounts.{LoginResolver, SignUpResolver}
    alias IgrejotecaWeb.Utils.Response
    alias Igrejoteca.Quiz.Score.Repository, as: ScoreRepository
    alias Igrejoteca.Quiz.Score
    alias IgrejotecaWeb.Utils.Translate

    action_fallback IgrejotecaWeb.FallbackController

    def login(conn, %{"identifier" => identifier, "password" => password}) do
        IO.inspect(identifier)
        params = %{identifier: identifier, password: password}

        LoginResolver.login(params)
        |> case do
            nil -> Response.unauthorized(conn)
            user ->
                score = ScoreRepository.get_score_by_user_id(user.id)

                user
                |> Map.put(:score, score)
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
        |> IO.inspect()
        |> case do
            {:ok, %User{} = user} ->
                {:ok, %Score{} = score} = ScoreRepository.create_score(%{"user_id"=> user.id, "score" => 0})
                IO.inspect(score)
                user
                |> Map.put(:score, score.score)
                |> gen_token()
                |> case do
                    nil -> Response.forbidden(conn)
                    data -> render(conn, "signup.json", auth: data)
                end
            {:error, changeset}->
                    error_list = Enum.map(changeset.errors, fn x ->
                        item = elem(x, 0)
                        {mensagem, _} = elem(x, 1)
                        Map.put_new(%{}, item, mensagem)
                    end)
                    translated_errors = Enum.map(error_list, fn error ->
                        Translate.translate_error(error, "pt")
                    end)
                    error = translated_errors
                    |> List.first()
                    |> Map.values

                    IO.inspect(error, label: "error")
                    conn
                    |> put_status(400)
                    |> render("auth_error_signup.json", error: List.first(error))
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
