module Metric

  # Used to track metrics

  class Track
    # Generate the url with query strings
    #
    # @param [String] metric Metric identifier
    # @param [Hash] options Options
    # @option options [Symbol] :amount Amount to track
    # @option options [Symbol] :trigger Flag for email notification
    # @return [String]
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

    # Uses a thread to perform the request
    # @note If this gem is used with Rails it will only track data in the production environment
    #
    # @param [String, Hash]
    # @return [nil]
    def self.track(metric, options = {})
      return if defined?(Rails) && !Rails.env.production?
      return if options[:amount] && options[:amount] == 0

      url = compose(metric, options)
      Thread.new do
        `curl "#{url}" 2>&1 ; `
      end
    end

    # CGI escape the metric name so spaces and characters are allowed
    #
    # @param [String]
    # @return [String]
    def self.parse_metric(metric)
      "&metric=#{CGI.escape(metric)}"
    end
  end
end
