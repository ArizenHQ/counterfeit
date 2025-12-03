require "spec_helper"
require 'webmock/rspec'
require "counterfeit/example/app"

RSpec.describe Counterfeit do
  before do
    Counterfeit.enable!(
      Counterfeit.plugins + [
      Counterfeit::Example,
    ])
  end

  describe ".VERSION" do
    it "has a version number" do
      expect(Counterfeit::VERSION).to_not be(nil)
    end
  end

  describe ".stub_plugins" do
    subject { Counterfeit.stub_plugins([plugin]) }

    let(:plugin) { Counterfeit::Example }

    before do
      allow(WebMock).to receive(:stub_request).and_call_original
    end

    after do
      # Reload file due to remove_const calls
      Counterfeit.send(:remove_const, :Example)
      load 'counterfeit/example/app.rb'
    end

    context "no endpoint is defined" do
      before do
        plugin.send(:remove_const, :ENDPOINT)
        plugin.send(:remove_const, :ENDPOINTS)
      end

      it "do not stubs endpoints" do
        subject

        expect(WebMock).to_not have_received(:stub_request).with(:any, /www.example.com/)
        expect(WebMock).to_not have_received(:stub_request).with(:any, /www.example2.com/)
        expect(WebMock).to_not have_received(:stub_request).with(:any, /www.example3.com/)
      end
    end

    context "single endpoint is defined" do
      before do
        plugin.send(:remove_const, :ENDPOINTS)
      end

      it "stubs single endpoint" do
        subject

        expect(WebMock).to have_received(:stub_request).with(:any, /www.example.com/)
        expect(WebMock).to_not have_received(:stub_request).with(:any, /www.example2.com/)
        expect(WebMock).to_not have_received(:stub_request).with(:any, /www.example3.com/)
      end
    end

    context "several endpoints are defined" do
      before do
        plugin.send(:remove_const, :ENDPOINT)
      end

      it "stubs several endpoints" do
        subject

        expect(WebMock).to_not have_received(:stub_request).with(:any, /www.example.com/)
        expect(WebMock).to have_received(:stub_request).with(:any, /www.example2.com/)
        expect(WebMock).to have_received(:stub_request).with(:any, /www.example3.com/)
      end
    end

    context "both single and several endpoint are defined" do
      it "stubs all endpoints" do
        subject

        expect(WebMock).to have_received(:stub_request).with(:any, /www.example.com/)
        expect(WebMock).to have_received(:stub_request).with(:any, /www.example2.com/)
        expect(WebMock).to have_received(:stub_request).with(:any, /www.example3.com/)
      end
    end
  end

  describe "request stubbing" do
    let(:response) { Net::HTTP.get("www.example.com", "/test") }

    it "should return a fake response" do
      expect(response).to eql({ result: 'ok' }.to_json)
      expect(a_request(:get, "www.example.com/test")).to have_been_made
    end
  end
end
