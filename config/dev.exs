use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :awesome_api_v2, AwesomeApiV2.Web.Endpoint,
  http:          [port: 4000],
  debug_errors:  true,
  code_reloader: true,
  check_origin:  false,
  watchers:      [
    node: [
      "node_modules/brunch/bin/brunch",
      "watch",
      "--stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :awesome_api_v2, AwesomeApiV2.Web.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/awesome_api_v2/web/views/.*(ex)$},
      ~r{lib/awesome_api_v2/web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :awesome_api_v2, AwesomeApiV2.Repo,
  adapter: Ecto.Adapters.Postgres,
  # username:       "postgres",
  # password:       "postgres",
  database:         "mlsdev-chat_development2",
  hostname:         "localhost",
  pool_size:        10,
  #
  # TODO: :(
  #
  # resolve conflicts with rails
  #
  migration_source: "phoenix_schema_migrations"

config :awesome_api_v2, AwesomeApiV2.Mailer,
  adapter: Bamboo.LocalAdapter
