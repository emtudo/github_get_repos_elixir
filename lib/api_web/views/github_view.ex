defmodule ApiWeb.GithubView do
  alias Api.Repo
  use ApiWeb, :view

  def render("repos.json", %{repos: [%Repo{} | _repos] = repos}), do: repos
end
