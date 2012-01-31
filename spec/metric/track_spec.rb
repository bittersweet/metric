require 'spec_helper'

describe Metric::Track do
  it "composes the request url" do
    Metric::Track.compose("hits").should == "https://api.metric.io/track?api_key=spec&metric=hits"
  end

  it "gets correct url when tracking" do
    Metric::Track.should_receive(:quit_early?).and_return(false)
    Metric::Track.should_receive(:compose).with("hits", {})
    Metric::Track.track("hits")
  end

  it "encodes the input" do
    url = "https://api.metric.io/track?api_key=spec&metric=hits+and+spaces"
    Metric::Track.compose("hits and spaces").should == url
  end

  it "sends custom amount" do
    url = "https://api.metric.io/track?api_key=spec&metric=hits&amount=42"
    Metric::Track.compose("hits", {:amount => 42}).should == url
  end

  it "does nothing if amount is 0" do
    Metric::Track.should_not_receive(:compose)
    Metric::Track.track("hits", {:amount => 0})
  end

  it "passes in custom date" do
    url = "https://api.metric.io/track?api_key=spec&metric=hits&date=20120101"
    Metric::Track.compose("hits", {:date => "20120101"}).should == url
  end

  it "passes in meta information" do
    url = "https://api.metric.io/track?api_key=spec&metric=payment&meta=userid%3A+1"
    Metric::Track.compose("payment", {:meta => "userid: 1"}).should == url
  end

  it "sends trigger param" do
    url = "https://api.metric.io/track?api_key=spec&metric=hits&trigger=1"
    Metric::Track.compose("hits", {:trigger => true}).should == url
  end
end

