# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nfl_backend,
  ecto_repos: [NflBackend.Repo]

# Configures the endpoint
config :nfl_backend, NflBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "04ap84j+VNKas6R/YG2rqS49ewVyfivqSiRiHoYF4nHsJ52XELo4vGAwDEQ71OTg",
  render_errors: [view: NflBackendWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: NflBackend.PubSub,
  live_view: [signing_salt: "MkF6jwtw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
