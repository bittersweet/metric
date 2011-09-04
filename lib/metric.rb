require 'metric/configuration'
require 'metric/track'
require 'open-uri'
require 'cgi'

module Metric
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Metric::Configuration.new
      yield(configuration)
    end

    def track(metric, options = {})
      Metric::Track.track(metric, options)
    end
  end
end

