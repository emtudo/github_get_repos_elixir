defmodule Api.Github.Client do
  alias Api.Github.ClientBehaviour
  alias Api.{Error, GithubRepo}
  use Tesla
  alias Tesla.Env

  @behaviour ClientBehaviour

  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]

  @base_url "https://api.github.com"

  def get_repos(base_rul \\ @base_url, username) do
    "#{base_rul}/users/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 404}}),
    do: {:error, Error.build_github_username_not_found_error()}

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, parse_repos(body)}
  end

  defp handle_get(_),
    do: {:error, Error.build(:internal_server_error, "Internal Server Error.")}

  defp parse_repos(repos) do
    repos
    |> Enum.map(&GithubRepo.build/1)
  end
end
