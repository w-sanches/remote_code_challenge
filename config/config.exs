# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :remote_code_challenge,
  ecto_repos: [RemoteCodeChallenge.Repo]

# Configures the endpoint
config :remote_code_challenge, RemoteCodeChallengeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jd/rCC+T+NnIep/CsbQOkjTYnrAYDevI6SaIZLQYg+FrN+XdDrg65BcpOWr3bmSv",
  render_errors: [view: RemoteCodeChallengeWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: RemoteCodeChallenge.PubSub,
  live_view: [signing_salt: "suJRbwSK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
