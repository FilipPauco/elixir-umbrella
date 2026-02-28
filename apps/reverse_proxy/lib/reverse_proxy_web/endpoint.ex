defmodule ReverseProxyWeb.Endpoint do
  use PhoenixReverseProxy, otp_app: :reverse_proxy

  # IMPORTANT: All of these macros except for proxy_default/1
  #            can take a path prefix so they all have an arity
  #            of 2 and 3.

  # Maps to http(s)://api.example.com/v1
  # proxy("api.example.com", "v1", ExampleApiV1.Endpoint)

  # Maps to http(s)://api.example.com/v2
  # proxy("api.example.com", "v2", ExampleApiV2.Endpoint)

  # Matches the domain only and no subdomains
  # proxy("example.com", ExampleWeb.Endpoint)
  # Matched any subdomain such as http(s)://images.example.com/
  # but not the domain itself http(s)://example.com/
  # proxy_subdomains("example.com", ExampleSubs.Endpoint)

  # Matches all subdomains and the domain itself.
  # This is equivalent to combining these rules:
  #   proxy("foofoovalve.com", FoofooValve.Endpoint)
  #   proxy_subdomains("foofoovalve.com", FoofooValve.Endpoint)
  # proxy_all("foofoovalve.com", FoofooValve.Endpoint)

  # Matches anything not matched above
  proxy_path("/attendance", AttendanceWeb.Endpoint)
  proxy_default(CoreWeb.Endpoint)
end
