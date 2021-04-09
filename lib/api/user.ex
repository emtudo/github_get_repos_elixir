defmodule Api.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @required_params [:password]

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
  end

  def changeset(user \\ %__MODULE__{}, params) do
    fields = @required_params

    user
    |> cast(params, @required_params)
    |> validate_required(fields)
    |> validate_length(:password, min: 8)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
