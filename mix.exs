defmodule AwesomeApiV2.Mixfile do
  use Mix.Project

  @project_version "0.1.4"
  @project_url     "https://github.com/MLSDev/awesome_api_v2"

  def project do
    [
      app:             :awesome_api_v2,
      version:         @project_version,
      elixir:          "~> 1.5",
      elixirc_paths:   elixirc_paths(Mix.env),
      compilers:       [:phoenix, :gettext] ++ Mix.compilers,
      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases:         aliases(),
      deps:            deps(),
      docs: [
        extras: ["README.md"],
        main:   "readme"
      ],
      description: "AwesomeApiV2 has no certain purpose to get everythig done. Its just test project. " <>
                   "To explore phoenix and elixir tools.",
      package: [
        maintainers: ["Dmytro Stepaniuk"],
        licenses:    ["MIT"],
        links:       %{"Gitlab" => @project_url}
      ],
      source_url:   @project_url,
      homepage_url: @project_url,
      test_coverage: [
        tool:      ExCoveralls,
        test_task: "espec"
      ],
      preferred_cli_env: [
        "coveralls":        :test,
        "coveralls.detail": :test,
        # "coveralls.post":   :test,
        "coveralls.html":   :test
        ],
      # spec_paths: ["spec"], # by default
      # spec_pattern: "*_spec.exs" # by default
      docs: [
        main:   "AwesomeApiV2 & co", # The main page in the docs
        # logo:   "path/to/logo.png",
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {AwesomeApiV2.Application, []},
      extra_applications: [
        :phoenix,
        :phoenix_pubsub,
        :cowboy,
        :logger,
        :gettext,
        :phoenix_ecto,
        :postgrex,
        :comeonin,
        :exq,
        :exq_ui,
        :bamboo,
        :bamboo_smtp,
        :scrivener_ecto,
        :cors_plug,
        :crutches,
        :elixir_make,
        :phoenix_html,
        :secure_random,
        :edeliver,
        :ex_aws,
        :hackney,
        :poison,
        :arc,
        :arc_ecto,
        :amqp
        # :ex_machina
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix,             "~> 1.3"},               #
      {:phoenix_pubsub,      ">= 0.0.0"},             #
      {:phoenix_ecto,        ">= 0.0.0"},             #
      {:phoenix_html,        ">= 0.0.0"},             #
      {:phoenix_live_reload, ">= 0.0.0", only: :dev}, # recompile assets on files changin
      {:postgrex,            ">= 0.0.0"},             #
      {:gettext,             ">= 0.0.0"},             #
      {:cowboy,              ">= 0.0.0"},             # SERVER
      {:comeonin,            ">= 0.0.0"},             #
      {:crutches,            ">= 0.0.0"},             #
      {:cors_plug,           ">= 0.0.0"},             #
      {:secure_random,       ">= 0.0.0"},             # SecureRandom
      {:exq,                 ">= 0.0.0"},             # background processing
      {:exq_ui,              ">= 0.0.0"},             # web ui for exq
      {:bamboo,              ">= 0.0.0"},             # smtp
      {:bamboo_smtp,         ">= 0.0.0"},             # smtp
      {:scrivener_ecto,      ">= 0.0.0"},             # Scrivener.Ecto allows you to paginate your Ecto queries with Scrivener.
      {:edeliver,            ">= 0.0.0"},             # deployment (rel/config.exs)
      {:distillery,          ">= 0.0.0", warn_missing: false, runtime: false}, # mix release
      {:arc,                 ">= 0.0.0"},             # image processing and storing
      {:arc_ecto,            ">= 0.0.0"},             # deals with attachments inside ecto model
      {:ex_aws,              ">= 0.0.0"},             # aws client
      # {:hackney,             ">= 0.0.0"},             # used by bamboo
      # ==> Generating boot script
      # ==> Release failed, during .boot generation:
      #   Duplicated modules:
      #     unicode_util specified in stdlib and unicode_util_compat
      {:hackney,             "== 1.8.0", override: true}, # workaround for some problem TODO: check me later
      #
      # ATTENTION! overrided!
      #
      {:poison,              ">= 0.0.0", override: true}, # Poison is a new JSON library for Elixir focusing on wicked-fast speed without sacrificing simplicity, completeness, or correctness.
      {:sweet_xml,           ">= 0.0.0"},             # some depency?
      {:inflex,              ">= 0.0.0"},             # An Elixir library for handling word inflections.
      {:phoenix_swagger,     ">= 0.0.0"},             # super-duper swagger documentation provided by elixir lang O_o
      {:ex_json_schema,      ">= 0.0.0"},             # optional
      {:amqp,                ">= 0.0.0"},             # see lib/mq to check the idea of micro-services architecture
      {:excoveralls,         ">= 0.0.0", only: :test},# An elixir library that reports test coverage statistics, with the option to post to coveralls.io service
      {:espec,               ">= 0.0.0", only: :test},# ESpec is inspired by RSpec and the main idea is to be close to its perfect DSL.
      {:espec_phoenix,       ">= 0.0.0", only: :test},# ESpec.Phoenix is a lightweight wrapper around ESpec which brings BDD to Phoenix web framework.
      # {:decorator,           ">= 0.0.0"}              # A function decorator is a "@decorate" annotation that is put just before a function definition
      {:faker,               ">= 0.0.0", only: :test},
      {:bcrypt_elixir,       ">= 0.0.0"},
      #
      # TODO: delme ?!
      #
      # {:ex_machina,          ">= 0.0.0", only: :test} # ExMachina makes it easy to create test data and associations
      {:ex_doc,              ">= 0.0.0", only: :dev, runtime: false} # ExDoc is a tool to generate documentation for your Elixir projects.
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": [
        "ecto.create",
        "ecto.migrate",
        "run priv/repo/seeds.exs"
      ],
      "ecto.reset": [
        "ecto.drop",
        "ecto.setup"
        ],
      "test": [
        "ecto.create --quiet",
        "ecto.migrate", "test"
      ],
      "swagger": ["phx.swagger.generate priv/static/swagger.json"]
    ]
  end
end
