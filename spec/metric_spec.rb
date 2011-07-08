require 'spec_helper'

describe Metric do
  before do
    reset_config
  end

  it "calls metric.io" do
    stub_request(:get, "http://metric.io/track.js").
      with(:query => {"api_key" => "spec", "metric" => "hits"}).
      to_return(:status => 200, :body => "{\"total\":1}", :headers => {})
    Metric.track("hits").should == "{\"total\":1}"
  end

  it "encodes the request url" do
    Metric.parse_metric("hits and spaces").should == "&metric=hits+and+spaces"
  end

  it "sends trigger param" do
    stub_request(:get, "http://metric.io/track.js").
      with(:query => {"api_key" => "spec", "metric" => "hits", "trigger" => "1"}).
      to_return(:status => 200, :body => "{\"total\":1}", :headers => {})
    Metric.track("hits", true).should == "{\"total\":1}"
  end
end

