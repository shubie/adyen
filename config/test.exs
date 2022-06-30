import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :adyen, AdyenWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "snhgJLFTnuXyqqA9hzhHPlhD6OoIKDsaOeIt7iHhQ1WzzJCby3ytjJmsliLwpLbX",
  server: false

# In test we don't send emails.
config :adyen, Adyen.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
