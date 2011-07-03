require 'spec_helper'

describe Metric do
  before do
    Metric.configure {|config| config.api_key = "spec"}
    stub_request(:get, "http://metric.io/track.js").
      with(:query => {"api_key" => "spec", "metric" => "hits"}).
      to_return(:status => 200, :body => "", :headers => {})
  end

  it "calls metric.io" do
    Metric.track("hits")
  end
end

