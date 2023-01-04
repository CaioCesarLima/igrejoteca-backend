defmodule Igrejoteca.Repo do
  use Ecto.Repo,
    otp_app: :igrejoteca,
    adapter: Ecto.Adapters.Postgres
end
