defmodule Igrejoteca.Utils.Hashing do

    @doc false
    def create(plain) do
        plain
        |> Argon2.hash_pwd_salt
    end

    @doc false
    def validate(plain, hashed) do
        plain
        |> Argon2.verify_pass(hashed)
    end
end
