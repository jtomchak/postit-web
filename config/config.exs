# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :postit,
  ecto_repos: [Postit.Repo]

config :postit, :config,
  codefresh_auth_token: System.get_env("CODEFRESH_AUTH_TOKEN"),
  codefresh_pipeline_id: System.get_env("CODEFRESH_PIPELINE_ID")

# Configures the endpoint
config :postit, PostitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DCrs5e9HHwyuWRl8ez3AetNGWyJsqzheDwG+Jh14ZQoKuQ1CzsmSQjA2NwcrrZgL",
  render_errors: [view: PostitWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Postit.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Ueberauth
# Configures Ueberauth's Auth0 auth provider key's are in the `Mix.env().exs`
config :ueberauth, Ueberauth,
  providers: [
    auth0: {Ueberauth.Strategy.Auth0, []}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
