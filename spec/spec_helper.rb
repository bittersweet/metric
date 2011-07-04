require File.expand_path('../../lib/metric', __FILE__)
require 'ruby-debug'
require 'webmock/rspec'

def reset_config
  Metric.configuration = nil
  Metric.configure do |config|
    config.api_key = "spec"
  end
end

