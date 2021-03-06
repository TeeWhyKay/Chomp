Geocoder.configure(
  # Geocoding options
  # timeout: 3,                 # geocoding service timeout (secs)
  lookup: :mapbox, # name of geocoding service (symbol)
  country: 'sg',
  # ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
  # language: :en,              # ISO-639 language code
  # use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  api_key: "pk.eyJ1IjoidGVld2h5a2F5IiwiYSI6ImNrc3lkZXB5azJpbWoybmt0MXQwMGVib3UifQ.1elDNvnLbuHZ1dm8NOu8fg", # API key for mapbox
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
  # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  units: :km # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear
)
