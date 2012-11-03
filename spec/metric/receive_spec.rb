require 'spec_helper'

describe Metric::Receive do
  it "generates correct hash via secret_token" do
    Metric::Receive.generate_token("hits", "week").should == "47639a31c68c36a3406870dfff900679"
  end

  context "generating correct url" do
    it "total" do
      result = "https://api.metric.io/v1/sites/spec/statistics?metric=hits&range=total&token=e66652e1c3e7fdda10d6fb97cb279622"
      Metric::Receive.compose("hits", "total").should == result
    end

    it "today" do
      result = "https://api.metric.io/v1/sites/spec/statistics?metric=hits&range=today&token=1650709162cd5e699e079e14f8e1decc"
      Metric::Receive.compose("hits", "today").should == result
    end

    it "week" do
      result = "https://api.metric.io/v1/sites/spec/statistics?metric=hits&range=week&token=47639a31c68c36a3406870dfff900679"
      Metric::Receive.compose("hits", "week").should == result
    end

    it "month" do
      result = "https://api.metric.io/v1/sites/spec/statistics?metric=hits&range=month&token=f66049db427350067ed60fb6c986d687"
      Metric::Receive.compose("hits", "month").should == result
    end
  end

  it "grabs actual data" do
    stub_request(:get, "https://api.metric.io/v1/sites/spec/statistics?metric=hits&range=total&token=e66652e1c3e7fdda10d6fb97cb279622").
      to_return(:status => 200, :body => "{\"total\":\"1\"}", :headers => {})
    Metric::Receive.receive("hits", "total").should == {"total" => "1"}
  end
end

