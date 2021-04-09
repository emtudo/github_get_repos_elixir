# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api,
  ecto_repos: [Api.Repo],
  generators: [binary_id: true]

config :api, Api.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :api, ApiWeb.Auth.Guardian,
  issuer: "api_github",
  secret_key: "dduOHdwSr6toH1+RukfvsUekTJxMKGQbGcDywTYNelsQOKZJG5clVKw2GaxpniXp",
  ttl: {1, :minute}

config :api, ApiWeb.Auth.Pipeline,
  module: ApiWeb.Auth.Guardian,
  error_handler: ApiWeb.Auth.ErrorHandler

# Configures the endpoint
config :api, ApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q0SuzxhfzhcTeeeiO09Y3uujwe+A/RzAz3nwVfB5facmH3b35PGsSjYILcZDlu38",
  render_errors: [view: ApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Api.PubSub,
  live_view: [signing_salt: "GzR2hFBp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
