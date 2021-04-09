defmodule ApiWeb.UserCreateController do
  use ApiWeb, :controller
  alias Api.User
  alias ApiWeb.Auth.Guardian
  alias ApiWeb.FallbackController

  action_fallback FallbackController

  def handle(conn, params) do
    with {:ok, %User{} = user} <- Api.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> put_view(ApiWeb.UserView)
      |> render("create.json", token: token, user: user)
    end
  end
end
