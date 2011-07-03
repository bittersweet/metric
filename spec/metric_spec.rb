require 'spec_helper'

describe Metric do
  before do
    reset_config
    stub_request(:get, "http://metric.io/track.js").
      with(:query => {"api_key" => "spec", "metric" => "hits"}).
      to_return(:status => 200, :body => "{\"total\":1}", :headers => {})
  end

  it "calls metric.io" do
    Metric.track("hits").should == "{\"total\":1}"
  end
end

