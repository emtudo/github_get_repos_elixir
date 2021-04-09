defmodule Api do
  alias Api.Github.Client, as: GithubClient
  alias Api.Users.Create, as: UserCreate
  alias Api.Users.Get, as: UserGet

  defdelegate get_repos(username), to: GithubClient, as: :get_repos
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user_by_id(user_id), to: UserGet, as: :by_id
end
