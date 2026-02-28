defmodule ReverseProxy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    :logger.add_primary_filter(:tcp_noise, {&__MODULE__.filter_tcp_noise/2, []})

    children = [
      ReverseProxyWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:reverse_proxy, :dns_cluster_query) || :ignore},
      # {Phoenix.PubSub, name: ReverseProxy.PubSub},
      # Start a worker by calling: ReverseProxy.Worker.start_link(arg)
      # {ReverseProxy.Worker, arg},
      # Start to serve requests, typically the last entry
      ReverseProxyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ReverseProxy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ReverseProxyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
