require 'spec_helper'

describe Metric::Util do
  it 'builds a nested query string' do
    object = {"amount" => 1, "customer" => {"id" => "1"}}
    Metric::Util.build_query_string(object).should == "amount=1&customer%5Bid%5D=1"
  end

  it 'skips nil values' do
    object = {"amount" => 1, "date" => nil}
    Metric::Util.build_query_string(object).should == "amount=1"
  end
end
