module Metric
  class Configuration
    attr_accessor :api_key

    # Allows setting a different host, used for development purposes
    attr_accessor :metric_host

    # Used to generate a hash for getting data out
    attr_accessor :secret_key

    def initialize
      @metric_host = "http://api.metric.io"
    end
  end
end
