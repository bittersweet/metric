require 'digest/md5'
require 'multi_json'

module Metric
  class Receive
    def self.generate_token(metric)
      Digest::MD5.hexdigest(Metric.configuration.secret_key + metric)
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

    def self.receive(metric, range)
      url = compose(metric, range)
      response = connection.get(url)
      MultiJson.decode(response.body)
    end

    def self.parse_metric(metric)
      "&metric=#{CGI.escape(metric)}"
    end
  end
end

