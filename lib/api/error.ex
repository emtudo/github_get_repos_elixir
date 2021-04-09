defmodule Api.Error do
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  def build_github_username_not_found_error, do: build(:not_found, "Username not found.")
  def build_user_not_found_error, do: build(:not_found, "User not found.")
  def build_unauthorized, do: build(:unauthorized, "Please verify your credentials.")
end
