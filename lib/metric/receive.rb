require 'digest/md5'
require 'faraday'
require 'multi_json'

module Metric

  # Fetch data via the metric.io API

  class Receive
    # Generate a hash of the site's secret_key and metric identifier
    #
    # @param [String] metric Metric identifier
    # @return [String]
    def self.generate_token(metric, range)
      Digest::MD5.hexdigest(Metric.configuration.secret_key + metric + range)
    end

    # Generate the url with query strings
    #
    # @param [String] metric Metric identifier
    # @param [String] range Range identifier, either total, today, week or month
    # @return [String]
    def self.compose(metric, range)
      api_key = Metric.configuration.api_key
      url = Metric.configuration.protocol + "://" + Metric.configuration.host
      url << "/v1/sites/#{api_key}/statistics"
      url << parse_metric(metric)
      url << "&range=" + range
      url << "&token=" + generate_token(metric, range)
    end

    # Returns and memoizes a Faraday connection
    #
    # @return [Faraday::Connection]
    def self.connection
      @connection ||= Faraday.new do |builder|
        builder.adapter :net_http
      end
    end

    # Perform the actual request and parse JSON
    #
    # @param [String] metric Metric identifier
    # @param [String] range Range identifier, either total, today, week or month
    # @return [Hash] response from the API
    def self.receive(metric, range)
      url = compose(metric, range)
      response = connection.get(url)
      MultiJson.decode(response.body)
    end

    # CGI escape the metric name so spaces and characters are allowed
    #
    # @param [String] metric Metric identifier
    # @return [String]
    def self.parse_metric(metric)
      "?metric=#{CGI.escape(metric)}"
    end
  end
end

