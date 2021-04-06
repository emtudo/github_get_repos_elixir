defmodule Api.Github.ClientBehaviour do
  alias Api.Error
  @callback get_repos(String.t()):: {:ok, map()} | {:error, Error.t()}
end
