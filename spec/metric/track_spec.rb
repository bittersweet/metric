require 'spec_helper'

describe Metric::Track do
  it "composes the request url" do
    Metric::Track.compose("hits").should == "https://api.metric.io/v1/sites/spec/track?metric=hits"
  end

  it "gets correct url when tracking" do
    Metric::Track.should_receive(:quit_early?).and_return(false)
    Metric::Track.should_receive(:compose).with("hits", {})
    Metric::Track.track("hits")
  end

  it "uses http when ssl is false" do
    Metric.configure do |config|
      config.ssl = false
    end
    Metric::Track.compose("hits").should == "http://api.metric.io/v1/sites/spec/track?metric=hits"
  end

  it "encodes the input" do
    result = "https://api.metric.io/v1/sites/spec/track?metric=hits+and+spaces"
    Metric::Track.compose("hits and spaces").should == result
  end

  it "sends custom amount" do
    result = "https://api.metric.io/v1/sites/spec/track?metric=hits&amount=42"
    Metric::Track.compose("hits", :amount => 42).should == result
  end

  it "does nothing if amount is 0" do
    Metric::Track.should_not_receive(:compose)
    Metric::Track.track("hits", :amount => 0)
  end

  it "passes in custom date" do
    result = "https://api.metric.io/v1/sites/spec/track?metric=hits&date=20120101"
    Metric::Track.compose("hits", :date => "20120101").should == result
  end

  it "passes in meta information" do
    result = "https://api.metric.io/v1/sites/spec/track?metric=payment&meta=userid%3A+1"
    Metric::Track.compose("payment", :meta => "userid: 1").should == result
  end

  it "sends trigger param" do
    result = "https://api.metric.io/v1/sites/spec/track?metric=hits&trigger=1"
    Metric::Track.compose("hits", :trigger => true).should == result
  end
end

