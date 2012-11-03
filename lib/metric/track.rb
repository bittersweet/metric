module Metric

  # Used to track metrics

  class Track
    # Generate the url with query strings
    #
    # @param [String] metric Metric identifier
    # @param [Hash] options Options
    # @option options [Symbol] :amount Amount to track
    # @option options [Symbol] :date Override the default date (today)
    # @option options [Symbol] :meta Pass in custom meta data about the metric
    # @option options [Symbol] :trigger Flag for email notification
    # @return [String]
    def self.compose(metric, options = {})
      amount = options[:amount]
      trigger = options[:trigger]
      date = options[:date]
      meta = options[:meta]

      api_key = Metric.configuration.api_key
      url = Metric.configuration.protocol + "://" + Metric.configuration.host
      url << "/v1/sites/#{api_key}/track"
      url << "?metric=#{CGI.escape(metric)}"
      url << "&amount=#{amount}" if amount
      url << "&date=#{date}" if date
      url << "&meta=#{CGI.escape(meta)}" if meta
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
