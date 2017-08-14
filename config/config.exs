# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :awesome_api_v2,
  ecto_repos: [AwesomeApiV2.Repo]

# Configures the endpoint
config :awesome_api_v2, AwesomeApiV2.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NNae+KHj8/Wf+luSEoELCdQsFu63FhInmS0px4UEdofGUd2BqOamXNI0HIlttpgB",
  render_errors: [
    view:    AwesomeApiV2.Web.ErrorView,
    accepts: ~w(html json)
  ],
  pubsub: [
    name:    AwesomeApiV2.PubSub,
    adapter: Phoenix.PubSub.PG2
  ]

# Configures Elixir's Logger
config :logger, :console,
  format:   "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#
# EXQ
#
config :exq,
  name:                   Exq,
  host:                   "127.0.0.1",
  port:                   6379,
  # password:              "optional_redis_auth",
  namespace:              "exq",
  concurrency:            50, #:infinite,
  queues:                 ["default"], # [{"default", 10_000}, {"mailers", 10}]
  # poll_timeout:           50,
  # scheduler_poll_timeout: 200,
  # scheduler_enable:       true,
  # start_on_application:   false,
  max_retries:            25
  # shutdown_timeout:       5000,


config :exq_ui,
  web_port:      4040,
  web_namespace: "/exq_ui",
  server:        true

config :awesome_api_v2, AwesomeApiV2.Mailer,
  adapter:  Bamboo.SMTPAdapter,
  server:   System.get_env("SMTP_SERVER"),
  port:     587, # 1025,
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  tls:      :if_available, # can be `:always` or `:never`
  ssl:      false, # can be `true`
  retries:  String.to_integer(System.get_env("SMTP_RETRIES_COUNT") || "1")

config :arc,
  storage:    Arc.Storage.S3, # or Arc.Storage.Local
  # storage:    Arc.Storage.Local,
  bucket:     {:system, "AWS_S3_BUCKET"}, # if using Amazon S3
  asset_host: {:system, "ASSET_HOST"},    # For a value not known until runtime
  region:     {:system, "ASSET_REGION"},  # "eu-central-1",
  s3: [
    scheme: "https://",
    host:   "s3.eu-central-1.amazonaws.com",
    region: "eu-central-1"
  ]

config :ex_aws,
  access_key_id:     [{ :system, "AWS_ACCESS_KEY_ID" },     :instance_role],
  secret_access_key: [{ :system, "AWS_SECRET_ACCESS_KEY" }, :instance_role]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{ Mix.env }.exs"
