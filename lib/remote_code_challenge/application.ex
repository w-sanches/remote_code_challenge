defmodule RemoteCodeChallenge.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      RemoteCodeChallenge.Repo,
      # Start the Telemetry supervisor
      RemoteCodeChallengeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RemoteCodeChallenge.PubSub},
      # Start the Endpoint (http/https)
      RemoteCodeChallengeWeb.Endpoint,
      # Start a worker by calling: RemoteCodeChallenge.Worker.start_link(arg)
      {RemoteCodeChallenge.PointsManagerWorker, points_manager_config()}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RemoteCodeChallenge.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RemoteCodeChallengeWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp points_manager_config do
    %{max_number: Enum.random(0..100), timestamp: nil}
  end
end
