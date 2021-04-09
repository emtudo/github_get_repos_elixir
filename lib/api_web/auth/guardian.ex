defmodule ApiWeb.Auth.Guardian do
  use Guardian, otp_app: :api
  alias Api.{Error, User}

  def subject_for_token(%User{id: id}, _clams), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> Api.get_user_by_id()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- Api.get_user_by_id(user_id),
         true <- Bcrypt.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false -> {:error, Error.build_unauthorized()}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missions params")}
end
