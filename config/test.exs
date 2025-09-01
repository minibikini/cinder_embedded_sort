import Config
config :ash, policies: [show_policy_breakdowns?: true], disable_async?: true

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :cinder_embedded_sort, CinderEmbeddedSort.Repo,
  database: Path.expand("../cinder_embedded_sort_test.db", __DIR__),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cinder_embedded_sort, CinderEmbeddedSortWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "pw0hCW+tWyl4mXH/snjDJciKGTgVxLLAh8Fzs1uamzE+cAbAbI4Q4JKnittYAnMO",
  server: false

# In test we don't send emails
config :cinder_embedded_sort, CinderEmbeddedSort.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
