defmodule S3.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      S3.Repo,
      # Start the Telemetry supervisor
      S3Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: S3.PubSub},
      # Start the Endpoint (http/https)
      S3Web.Endpoint
      # Start a worker by calling: S3.Worker.start_link(arg)
      # {S3.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: S3.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    S3Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
