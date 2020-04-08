# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :postit,
  ecto_repos: [Postit.Repo]

# Configures the endpoint
config :postit, PostitWeb.Endpoint,
  secret_key_base: "DCrs5e9HHwyuWRl8ez3AetNGWyJsqzheDwG+Jh14ZQoKuQ1CzsmSQjA2NwcrrZgL",
  render_errors: [view: PostitWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Postit.PubSub, adapter: Phoenix.PubSub.PG2]

# Actual Timezones
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

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

# Bamboo SMTP Email configuration
config :postit, Postit.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_KEY")

# Stripity configuration
config :stripity_stripe, api_key: System.get_env("STRIPE_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
