defmodule ApiWeb.GithubView do
  alias Api.GithubRepo
  use ApiWeb, :view

  def render("repos.json", %{repos: [%GithubRepo{} | _repos] = repos, new_token: new_token}) do
    %{
      repos: repos,
      new_token: new_token
    }
  end
end
