require 'spec_helper'

describe Metric do
  before do
    reset_config
  end

  it "composes the request url" do
    Metric.compose("hits").should == "http://metric.io/track.js?api_key=spec&metric=hits"
  end

  it "gets correct url when tracking" do
    Metric.should_receive(:compose).with("hits", {})
    Metric.track("hits")
  end

  it "encodes the request url" do
    Metric.parse_metric("hits and spaces").should == "&metric=hits+and+spaces"
  end

  it "sends trigger param" do
    url = "http://metric.io/track.js?api_key=spec&metric=hits&trigger=1"
    Metric.compose("hits", {:trigger => true}).should == url
  end
end

