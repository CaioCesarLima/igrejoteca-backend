defmodule IgrejotecaWeb.Resolvers.Accounts.SignUpResolver do

    alias Igrejoteca.Accounts.Repository

    def signup(user_params) do
        Repository.create_user(user_params)
    end
end
