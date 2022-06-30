defmodule Adyen.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AdyenWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Adyen.PubSub},
      # Start the Endpoint (http/https)
      AdyenWeb.Endpoint
      # Start a worker by calling: Adyen.Worker.start_link(arg)
      # {Adyen.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Adyen.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AdyenWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
