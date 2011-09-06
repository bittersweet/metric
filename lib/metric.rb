require 'metric/configuration'
require 'metric/track'
require 'metric/receive'
require 'cgi'

module Metric
  class << self
    # Holds the configuration for easy access to settings
    attr_accessor :configuration

    # Configures gem options
    #
    # @param [Block]
    def configure
      self.configuration ||= Metric::Configuration.new
      yield(configuration)
    end

    # Tracks metrics
    #
    # @param [String, Hash]
    # @return [nil]
    def track(metric, options = {})
      Metric::Track.track(metric, options)
    end

    # Fetches data from the API
    #
    # @param [String, String]
    # @return [Hash]
    def receive(metric, range)
      Metric::Receive.receive(metric, range)
    end
  end
end

