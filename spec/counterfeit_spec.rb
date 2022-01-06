require "spec_helper"
require 'webmock/rspec'
require "counterfeit/example/app"

RSpec.describe Counterfeit do
  
  let(:response) { Net::HTTP.get("www.example.com", "/test") }

  before do
    Counterfeit.enable!(
      Counterfeit.plugins + [
      Counterfeit::Example,
    ])
  end

  it "has a version number" do
    expect(Counterfeit::VERSION).not_to be nil
  end

  it "should return a fake response" do
    response
    expect(a_request(:get, "www.example.com/test")).to have_been_made
  end
end
