defmodule ApiWeb.GithubRepoIndexController do
  alias Api.GithubRepo
  use ApiWeb, :controller
  alias ApiWeb.FallbackController

  action_fallback FallbackController

  def handle(conn, params) do
    username = Map.get(params, "username")

    with {:ok, [%GithubRepo{} | _repos] = repos} <- Api.get_repos(username) do
      conn
      |> put_status(:ok)
      |> put_view(ApiWeb.GithubView)
      |> render("repos.json", repos: repos)
    end
  end
end
