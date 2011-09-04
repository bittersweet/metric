require 'spec_helper'

describe Metric do
  before do
    reset_config
  end

  it "passes through options to correct method" do
    Metric::Track.should_receive(:compose).with("hits", {})
    Metric.track("hits")
  end
end

