use Mix.Config

config :each_share, EachShare.Repo,
  username: "postgres",
  password: "postgres",
  database: "each_share_dev", # usando o mesmo banco de dados por enquanto
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :each_share, EachShareWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "localhost", port: {:system, "PORT"}],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  root: ".",
  version: Application.spec(:each_share, :vsn)

# Do not print debug messages in production
config :logger, level: :info
#import_config "prod.secret.exs"
