module Metric
  class Configuration
    attr_accessor :api_key

    # Allows setting a different host, used for development purposes
    attr_accessor :metric_host

    def initialize
      @metric_host = "http://api.metric.io"
    end
  end
end
