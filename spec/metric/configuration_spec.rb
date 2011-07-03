require 'spec_helper'

describe Metric::Configuration do
  it "sets api key" do
    config = Metric::Configuration.new
    config.api_key = "test"
    config.api_key.should == "test"
  end

  it "configs" do
    Metric.configure do |config|
      config.api_key = "test"
    end
    Metric.configuration.api_key.should == "test"
  end
end
