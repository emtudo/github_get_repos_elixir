defmodule Api.GithubRepo do
  @keys [:id, :name, :description, :html_url, :stargazers_count]

  @enforce_keys @keys

  @derive {Jason.Encoder, only: @keys}
  defstruct @keys

  def build(%{
        "id" => id,
        "name" => name,
        "description" => description,
        "html_url" => html_url,
        "stargazers_count" => stargazers_count
      }) do
    %__MODULE__{
      id: id,
      name: name,
      description: description,
      html_url: html_url,
      stargazers_count: stargazers_count
    }
  end
end
