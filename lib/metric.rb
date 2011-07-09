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

    def compose(metric, options = {})
      amount = options[:amount]
      trigger = options[:trigger]

      key = "?api_key=" + Metric.configuration.api_key
      url = Metric.configuration.metric_host + '/track.js'
      url << key
      url << parse_metric(metric)
      url << "&amount=#{amount}" if amount
      url << "&trigger=1" if trigger
      url
    end

    def track(metric, options = {})
      return if defined?(Rails) && !Rails.env.production?

      url = compose(metric, options)
      Thread.new do
        `curl "#{url}" 2>&1 ; `
      end
    end

    def parse_metric(metric)
    "&metric=#{CGI.escape(metric)}"
    end
  end
end

