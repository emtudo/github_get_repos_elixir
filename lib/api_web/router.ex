defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ApiWeb.Auth.Pipeline
  end

  scope "/", ApiWeb do
    pipe_through :api

    post "/users", UserCreateController, :handle
    post "/auth/login", UserSigninController, :handle
  end

  scope "/", ApiWeb do
    pipe_through [:api, :auth]

    get "/users/:username/repos", GithubRepoIndexController, :handle
  end
end
