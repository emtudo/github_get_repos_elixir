defmodule ApiWeb.UserSigninController do
  use ApiWeb, :controller
  alias ApiWeb.Auth.Guardian
  alias ApiWeb.FallbackController

  action_fallback FallbackController

  def handle(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_view(ApiWeb.UserView)
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end
end
