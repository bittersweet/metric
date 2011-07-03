require 'metric/version'
require 'metric/configuration'
require 'open-uri'

module Metric
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Metric::Configuration.new
      yield(configuration)
    end

    def track(metric)
      key = "?api_key=" + Metric.configuration.api_key
      metric = "&metric=#{metric}"
      url = Metric.configuration.metric_host + '/track.js' + key + metric
      open(url).read
    end
  end
end

