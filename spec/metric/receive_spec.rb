require 'spec_helper'

describe Metric::Receive do
  it "generates correct hash via secret_token" do
    Metric::Receive.generate_token("hits").should == "c6daa87bcf8bf7cb4d1c74d872793e5e"
  end

  it "gets total" do
    request = "https://api.metric.io/receive?api_key=spec&token=c6daa87bcf8bf7cb4d1c74d872793e5e&metric=hits&range=total"
    Metric::Receive.compose("hits", "total").should == request
  end

  it "gets today" do
    request = "https://api.metric.io/receive?api_key=spec&token=c6daa87bcf8bf7cb4d1c74d872793e5e&metric=hits&range=today"
    Metric::Receive.compose("hits", "today").should == request
  end

  it "gets week" do
    request = "https://api.metric.io/receive?api_key=spec&token=c6daa87bcf8bf7cb4d1c74d872793e5e&metric=hits&range=week"
    Metric::Receive.compose("hits", "week").should == request
  end

  it "gets month" do
    request = "https://api.metric.io/receive?api_key=spec&token=c6daa87bcf8bf7cb4d1c74d872793e5e&metric=hits&range=month"
    Metric::Receive.compose("hits", "month").should == request
  end

  it "grabs actual data" do
    stub_request(:get, "https://api.metric.io/receive?api_key=spec&metric=hits&range=today&token=c6daa87bcf8bf7cb4d1c74d872793e5e").
      to_return(:status => 200, :body => "{\"total\":\"1\"}", :headers => {})
    Metric::Receive.receive("hits", "today").should == {"total" => "1"}
  end
end

