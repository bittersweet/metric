require 'spec_helper'

describe Metric do
  before do
    reset_config
  end

  it "composes the request url" do
    Metric.compose("hits").should == "http://api.metric.io/track?api_key=spec&metric=hits"
  end

  it "gets correct url when tracking" do
    Metric.should_receive(:compose).with("hits", {})
    Metric.track("hits")
  end

  it "encodes the request url" do
    Metric.parse_metric("hits and spaces").should == "&metric=hits+and+spaces"
  end

  it "sends trigger param" do
    url = "http://api.metric.io/track?api_key=spec&metric=hits&trigger=1"
    Metric.compose("hits", {:trigger => true}).should == url
  end

  it "sends custom amount" do
    url = "http://api.metric.io/track?api_key=spec&metric=hits&amount=42"
    Metric.compose("hits", {:amount => 42}).should == url
  end

  it "does nothing if amount is 0" do
    Metric.track("hits", {:amount => 0}).should == nil
  end
end

