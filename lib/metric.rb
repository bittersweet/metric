require 'metric/configuration'
require 'open-uri'
require 'cgi'

module Metric
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Metric::Configuration.new
      yield(configuration)
    end

    def track(metric, trigger = false)
      key = "?api_key=" + Metric.configuration.api_key
      url = Metric.configuration.metric_host + '/track.js'
      url << key
      url << parse_metric(metric)
      url << "&trigger=1" if trigger
      open(url).read
    end

    def parse_metric(metric)
    "&metric=#{CGI.escape(metric)}"
    end
  end
end

