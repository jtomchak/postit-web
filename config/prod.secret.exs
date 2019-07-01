# In this file, we load production configuration and
# secrets from environment variables. You can also
# hardcode secrets, although such is generally not
# recommended and you have to remember to add this
# file to your .gitignore.
use Mix.Config

# database_url =
#   System.get_env("DATABASE_URL") ||
#     raise """
#     environment variable DATABASE_URL is missing.
#     For example: ecto://USER:PASS@HOST/DATABASE
#     """

config :postit, Postit.Repo,
  # ssl: true,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  database: System.get_env("DB_NAME_BETA"),
  socket_dir: System.get_env("DB_SOCKET_DIR_BETA"),
  pool_size: 15

# secret_key_base =
#   System.get_env("SECRET_KEY_BASE") ||
#     raise """
#     environment variable SECRET_KEY_BASE is missing.
#     You can generate one by calling: mix phx.gen.secret
#     """

config :postit, PostitWeb.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")
