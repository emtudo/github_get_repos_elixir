defmodule ApiWeb.GithubView do
  alias Api.GithubRepo
  use ApiWeb, :view

  def render("repos.json", %{repos: [%GithubRepo{} | _repos] = repos}), do: repos
end
