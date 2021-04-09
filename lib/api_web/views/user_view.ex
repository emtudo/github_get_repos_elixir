defmodule ApiWeb.UserView do
  use ApiWeb, :view
  alias Api.User

  def render("create.json", %{user: %User{} = user, token: token}) do
    %{
      message: "User created!",
      user: %{
        id: user.id
      },
      token: token
    }
  end

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
