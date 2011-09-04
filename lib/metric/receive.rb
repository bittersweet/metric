require 'digest/md5'
require 'json'

module Metric
  class Receive
    def self.generate_token(metric)
      Digest::MD5.hexdigest(Metric.configuration.secret_token + metric)
    end

    def self.compose(metric, range)
      key = "?api_key=" + Metric.configuration.api_key
      url = Metric.configuration.metric_host + '/receive'
      url << key
      url << "&token=" + generate_token(metric)
      url << parse_metric(metric)
      url << "&range=" + range
    end

    def self.connection
      @connection ||= Faraday.new do |builder|
        builder.adapter :net_http
      end
    end

    def self.receive(metric, options = {})
      url = compose(metric, options)
      response = connection.get(url)
      JSON.parse(response.body)
    end

    def self.parse_metric(metric)
      "&metric=#{CGI.escape(metric)}"
    end
  end
end

