module Metric

  # Used for configuration of the Metric gem. The only required option is
  # api_key, secret_key is only used if you want to pull data out from the API
  # and host is used for local debugging purposes.

  class Configuration
    # Key used to identify the website
    attr_accessor :api_key

    # Allows setting a different host to send data to, used for development purposes
    attr_accessor :host

    # Used to generate a hash for getting data out
    attr_accessor :secret_key

    # Setting SSL on or off
    attr_accessor :ssl

    # Sets defaults
    def initialize
      @host = "api.metric.io"
      @ssl = true
    end

    # Protocol to use
    def protocol
      @ssl ? "https" : "http"
    end
  end
end
