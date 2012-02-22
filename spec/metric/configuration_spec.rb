require 'spec_helper'

describe Metric::Configuration do
  it "uses configuration defaults" do
    Metric.configure do |config|
      config.api_key = "test"
    end
    Metric.configuration.host.should == "api.metric.io"
  end

  it "configures metric host" do
    Metric.configure do |config|
      config.host = "localhost:5000"
    end
    Metric.configuration.host.should == "localhost:5000"
  end

  it "configures api_key" do
    Metric.configure do |config|
      config.api_key = "test"
    end
    Metric.configuration.api_key.should == "test"
  end

  it "configures secret key" do
    Metric.configure do |config|
      config.secret_key = "random_string"
    end
    Metric.configuration.secret_key.should == "random_string"
  end

  it "configures ssl" do
    Metric.configure do |config|
      config.ssl = false
    end
    Metric.configuration.ssl.should == false
  end
end
