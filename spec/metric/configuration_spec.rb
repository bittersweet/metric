require 'spec_helper'

describe Metric::Configuration do
  it "uses configuration defaults" do
    Metric.configure do |config|
      config.api_key = "test"
    end
    Metric.configuration.metric_host.should == "http://api.metric.io"
  end

  it "configures api_key" do
    Metric.configure do |config|
      config.api_key = "test"
    end
    Metric.configuration.api_key.should == "test"
  end

  it "configures metric host" do
    Metric.configure do |config|
      config.metric_host = "http://localhost:5000"
    end
    Metric.configuration.metric_host.should == "http://localhost:5000"
  end
end
