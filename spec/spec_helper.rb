require File.join(File.dirname(__FILE__), "../lib", "metric")
require 'ruby-debug'
require 'webmock/rspec'

def reset_config
  Metric.configuration = nil
  Metric.configure do |config|
    config.api_key = "spec"
  end
end

