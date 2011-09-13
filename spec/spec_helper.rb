require File.expand_path('../../lib/metric', __FILE__)
require 'ruby-debug'
require 'webmock/rspec'

def reset_config
  Metric.configuration = nil
  Metric.configure do |config|
    config.api_key = "spec"
    config.secret_key = "1234"
  end
end

RSpec.configure do |config|
  config.before(:all) { reset_config }
end
