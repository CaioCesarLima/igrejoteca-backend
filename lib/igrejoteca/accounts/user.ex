defmodule Igrejoteca.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  alias Igrejoteca.Utils.Hashing
  Igrejoteca.PrayerRequest.Testimonials.Testimony

  @email_regex ~r/^[a-z0-9._+-]+@[a-z0-9.-]+\.[a-z]{2,63}$/
  # @username_regex ~r/^[a-z0-9._+A-Z-]+$/
  # @username_min_length 4
  @min_password_lenght 8

  # Fields
  @cast_fields [:name, :email, :password]
  @mandatory_fields [:name, :email, :password]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @cast_fields)
    |> validate_required(@mandatory_fields)
    |> validate_email()
    |> validate_password()
  end

  defp validate_email(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)
  end

  defp validate_email(changeset),
    do: changeset

  # defp validate_username(%Ecto.Changeset{valid?: true} = changeset) do
  #   changeset
  #   |> validate_format(:username, @username_regex)
  #   |> validate_length(:username, min: @username_min_length)
  #   |> unique_constraint(:username)
  # end

  # defp validate_username(changeset),
  #   do: changeset

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: plain_password}} = changeset) do
    password_hash = Hashing.create(plain_password)

    changeset
    |> put_change(:password_hash, password_hash)
  end

  defp hash_password(changeset),
    do: changeset

  defp validate_password(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
    |> validate_length(:password, min: @min_password_lenght)
    |> validate_format(:password, ~r/\d+/)
    |> validate_format(:password, ~r/\w+/)
    |> validate_format(:password, ~r/[[:alpha:]]+/)
    |> hash_password()
  end

  defp validate_password(changeset),
    do: changeset
end
