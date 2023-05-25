defmodule Igrejoteca.Accounts.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "notifications" do
    field :expiration, :string
    field :token, :string
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:user_id, :token, :expiration])
    |> validate_required([:user_id, :token])
  end
end
