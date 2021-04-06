defmodule Api.Github.ClientTest do
  alias Api.Github.Client
  alias Api.{Error, Repo}
  use ExUnit.Case, async: true
  alias Plug.Conn
  import Api.Factory

  describe "get_repos/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when are username valid", %{bypass: bypass} do
      username = "emtudo"

      url = endpoint_url(bypass.port)

      body = ~s([
        {
          "id": 302488004,
          "name": "CIELO-API-3.0-PHP",
          "description": "SDK PHP da API 3.0 da Cielo",
          "html_url": "https://github.com/emtudo/CIELO-API-3.0-PHP",
          "stargazers_count": 0
        },
        {
          "id": 353321157,
          "name": "correios-cep-elixir",
          "description": "Find Brazilian addresses by postal code, directly from Correios API. No HTML parsers.",
          "html_url": "https://github.com/emtudo/correios-cep-elixir",
          "stargazers_count": 0
        }
      ])

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_repos(url, username)

      repo = build(:repo)
      expected_response =  {:ok,
        [
          %Repo{
            description: "SDK PHP da API 3.0 da Cielo",
            html_url: "https://github.com/emtudo/CIELO-API-3.0-PHP",
            id: 302_488_004,
            name: "CIELO-API-3.0-PHP",
            stargazers_count: 0
          },
          repo
        ]
      }

      assert response == expected_response
    end

    test "when the username was not found", %{bypass: bypass} do
      username = "emtudo"

      url = endpoint_url(bypass.port)

      body = ~s({
        "message": "Not Found",
        "documentation_url": "https://..."
      })

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.resp(404, body)
      end)

      response = Client.get_repos(url, username)

      expected_response =  {
        :error,
        %Error{
          result: "Username not found.",
          status: :not_found
        }
      }

      assert response == expected_response
    end

    test "When there is generic error", %{bypass: bypass} do
      username = "emtudo"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_repos(url, username)

      expected_response =  {:error, %Error{
        result: "Internal Server Error.", status: :internal_server_error}
      }

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
