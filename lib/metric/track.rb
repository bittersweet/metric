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
      date = options[:date]

      key = "?api_key=" + Metric.configuration.api_key
      url = Metric.configuration.metric_host + '/track'
      url << key
      url << parse_metric(metric)
      url << "&amount=#{amount}" if amount
      url << "&date=#{date}" if date
      url << "&trigger=1" if trigger
      url
    end

    # Track the metric
    # @note curl is called in a seperate thread so this won't block execution
    #
    # @param [String, Hash]
    # @return [nil]
    def self.track(metric, options = {})
      return if quit_early?(options)
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

    private

    # Check if Rails or Rack env is production, or amount is 0
    def self.quit_early?(options)
      return true if defined?(Rails) && !Rails.env.production?
      return true if ENV['RACK_ENV'] && ENV['RACK_ENV'] != "production"
      return true if options[:amount] && options[:amount] == 0
      false
    end
  end
end
