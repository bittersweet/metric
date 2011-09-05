require 'spec_helper'

describe Metric do
  before do
    reset_config
  end

  it "passes through options to track" do
    Metric::Track.should_receive(:track).with("hits", {})
    Metric.track("hits")
  end

  it "passes through options to receive" do
    Metric::Receive.should_receive(:receive).with("hits", "total")
    Metric.receive("hits", "total")
  end
end

