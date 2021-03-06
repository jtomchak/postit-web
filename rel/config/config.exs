use Mix.Config

port = String.to_integer(System.get_env("PORT") || "4000")

default_secret_key_base = :crypto.strong_rand_bytes(48) |> Base.encode64()
secret_key_base = System.get_env("SECRET_KEY_BASE") || default_secret_key_base

config :postit, PostitWeb.Endpoint,
  http: [port: port],
  url: [host: "postit.blog", port: 80],
  ssl: true,
  secret_key_base: secret_key_base
