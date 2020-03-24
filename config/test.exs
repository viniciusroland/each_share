use Mix.Config

# Configure your database
config :each_share, EachShare.Repo,
  username: "postgres",
  password: "postgres",
  database: "each_share_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :each_share, EachShareWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
