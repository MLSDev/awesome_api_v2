use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :awesome_api_v2, AwesomeApiV2.Web.Endpoint,
  http:   [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :awesome_api_v2, AwesomeApiV2.Repo,
  adapter:          Ecto.Adapters.Postgres,
  # username:       "postgres",
  # password:       "postgres",
  database:         "mlsdev-chat_test",
  hostname:         "localhost",
  pool:             Ecto.Adapters.SQL.Sandbox,
  migration_source: "phoenix_schema_migrations"

# comeonin allows us to speed up our tests by turning down the encryption
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1

# SMTP
config :awesome_api_v2, AwesomeApiV2.Mailer,
  adapter:  Bamboo.TestAdapter

