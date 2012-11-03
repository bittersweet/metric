require 'spec_helper'

describe Metric::Receive do
  it "generates correct hash via secret_token" do
    Metric::Receive.generate_token("hits").should == "c6daa87bcf8bf7cb4d1c74d872793e5e"
  end

  context "generating correct url" do
    it "total" do
      result = "https://api.metric.io/v1/sites/spec/statistics?metric=hits&range=total&token=c6daa87bcf8bf7cb4d1c74d872793e5e"
      Metric::Receive.compose("hits", "total").should == result
    end

    it "today" do
      result = "https://api.metric.io/v1/sites/spec/statistics?metric=hits&range=today&token=c6daa87bcf8bf7cb4d1c74d872793e5e"
      Metric::Receive.compose("hits", "today").should == result
    end

    it "week" do
      result = "https://api.metric.io/v1/sites/spec/statistics?metric=hits&range=week&token=c6daa87bcf8bf7cb4d1c74d872793e5e"
      Metric::Receive.compose("hits", "week").should == result
    end

    it "month" do
      result = "https://api.metric.io/v1/sites/spec/statistics?metric=hits&range=month&token=c6daa87bcf8bf7cb4d1c74d872793e5e"
      Metric::Receive.compose("hits", "month").should == result
    end
  end

  it "grabs actual data" do
    stub_request(:get, "https://api.metric.io/v1/sites/spec/statistics?metric=hits&range=total&token=c6daa87bcf8bf7cb4d1c74d872793e5e").
      to_return(:status => 200, :body => "{\"total\":\"1\"}", :headers => {})
    Metric::Receive.receive("hits", "total").should == {"total" => "1"}
  end
end

