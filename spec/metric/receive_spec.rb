require 'spec_helper'

describe Metric::Receive do
  it "generates correct hash via secret_token" do
    Metric::Receive.generate_token("hits").should == "c6daa87bcf8bf7cb4d1c74d872793e5e"
  end

  context "generating correct url" do
    it "total" do
      request = "https://api.metric.io/receive?api_key=spec&token=c6daa87bcf8bf7cb4d1c74d872793e5e&metric=hits&range=total"
      Metric::Receive.compose("hits", "total").should == request
    end

    it "today" do
      request = "https://api.metric.io/receive?api_key=spec&token=c6daa87bcf8bf7cb4d1c74d872793e5e&metric=hits&range=today"
      Metric::Receive.compose("hits", "today").should == request
    end

    it "week" do
      request = "https://api.metric.io/receive?api_key=spec&token=c6daa87bcf8bf7cb4d1c74d872793e5e&metric=hits&range=week"
      Metric::Receive.compose("hits", "week").should == request
    end

    it "month" do
      request = "https://api.metric.io/receive?api_key=spec&token=c6daa87bcf8bf7cb4d1c74d872793e5e&metric=hits&range=month"
      Metric::Receive.compose("hits", "month").should == request
    end
  end

  it "grabs actual data" do
    stub_request(:get, "https://api.metric.io/receive?api_key=spec&metric=hits&range=total&token=c6daa87bcf8bf7cb4d1c74d872793e5e").
      to_return(:status => 200, :body => "{\"total\":\"1\"}", :headers => {})
    Metric::Receive.receive("hits", "total").should == {"total" => "1"}
  end
end

