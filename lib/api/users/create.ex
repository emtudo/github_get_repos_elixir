defmodule Api.Users.Create do
  alias Ecto.Changeset
  alias Api.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> handle_insert()
  end

  defp handle_insert(%Changeset{valid?: true} = changeset) do
    Repo.insert(changeset)
  end

  defp handle_insert(error) do
    {:error, error}
  end
end
