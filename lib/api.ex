defmodule Api do
  alias Api.Github.Client, as: GithubClient

  defdelegate get_repos(username), to: GithubClient, as: :get_repos
end
