defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller
  alias Api.Error

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ApiWeb.ErrorView)
    |> render("error.json", result: result)
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
