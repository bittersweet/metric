require 'spec_helper'

describe Metric::Track do
  before do
    reset_config
  end

  it "composes the request url" do
    Metric::Track.compose("hits").should == "http://api.metric.io/track?api_key=spec&metric=hits"
  end

  it "gets correct url when tracking" do
    Metric::Track.should_receive(:compose).with("hits", {})
    Metric::Track.track("hits")
  end

  it "encodes the request url" do
    Metric::Track.parse_metric("hits and spaces").should == "&metric=hits+and+spaces"
  end

  it "sends trigger param" do
    url = "http://api.metric.io/track?api_key=spec&metric=hits&trigger=1"
    Metric::Track.compose("hits", {:trigger => true}).should == url
  end

  it "sends custom amount" do
    url = "http://api.metric.io/track?api_key=spec&metric=hits&amount=42"
    Metric::Track.compose("hits", {:amount => 42}).should == url
  end

  it "does nothing if amount is 0" do
    Metric::Track.track("hits", {:amount => 0}).should == nil
  end
end


