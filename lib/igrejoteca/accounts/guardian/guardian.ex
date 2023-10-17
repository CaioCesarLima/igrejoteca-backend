defmodule Igrejoteca.Accounts.Guardian do
    use Guardian, otp_app: :igrejoteca

    # alias Igrejoteca.Accounts

    def subject_for_token(%{id: id}, _claims) do
        {:ok, to_string(id)}
    end

    def resource_from_claims(%{"sub" => id}) do
        try do
            user = Igrejoteca.Accounts.Repository.get_user!(id)
            {:ok, user}
        rescue
            Ecto.NoResultsError ->
                {:error, :noresult}
        end
    end
end
