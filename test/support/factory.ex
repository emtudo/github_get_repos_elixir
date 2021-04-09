defmodule Api.Factory do
  use ExMachina
  alias Api.GithubRepo

  def repo_factory do
    %GithubRepo{
      description:
        "Find Brazilian addresses by postal code, directly from Correios API. No HTML parsers.",
      html_url: "https://github.com/emtudo/correios-cep-elixir",
      id: 353_321_157,
      name: "correios-cep-elixir",
      stargazers_count: 0
    }
  end
end
