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
    # @param [String] metric Metric identifier
    # @param [Hash] options Options
    # @return [Hash] API Response
    def track(metric, options = {})
      Metric::Track.track(metric, options)
    end

    # Fetches data from the API
    #
    # @param [String] metric Metric identifier
    # @param [String] range Range identifier, either total, today, week or month
    # @return [Hash] API Response
    def receive(metric, range)
      Metric::Receive.receive(metric, range)
    end
  end
end

