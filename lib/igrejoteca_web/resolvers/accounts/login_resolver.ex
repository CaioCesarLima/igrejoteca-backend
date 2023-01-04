defmodule IgrejotecaWeb.Resolvers.Accounts.LoginResolver do

    alias Igrejoteca.Accounts.Repository
    alias Igrejoteca.Utils.Hashing

    @doc false
    def login(params) do
        params.identifier
        |> String.contains?("@")
        |> case do
            true ->
                login_with_email(params.identifier)
            false ->
                login_with_username(params.identifier)
        end
        |> validate_password(params.password)
    end

    defp validate_password(nil, _password),
        do: nil

    defp validate_password(user, password) do
        password
        |> Hashing.validate(user.password_hash)
        |> case do
            true -> user
            false -> nil
        end
    end

    defp login_with_email(email) do
        email
        |> Repository.get_user_by_email()
    end

    defp login_with_username(username) do
        username
        |> Repository.get_user_by_username()
    end
end
