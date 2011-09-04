module Metric
  class Track
    def self.compose(metric, options = {})
      amount = options[:amount]
      trigger = options[:trigger]

      key = "?api_key=" + Metric.configuration.api_key
      url = Metric.configuration.metric_host + '/track'
      url << key
      url << parse_metric(metric)
      url << "&amount=#{amount}" if amount
      url << "&trigger=1" if trigger
      url
    end

    def self.track(metric, options = {})
      return if defined?(Rails) && !Rails.env.production?
      return if options[:amount] && options[:amount] == 0

      url = compose(metric, options)
      Thread.new do
        `curl "#{url}" 2>&1 ; `
      end
    end

    def self.parse_metric(metric)
    "&metric=#{CGI.escape(metric)}"
    end
  end
end
