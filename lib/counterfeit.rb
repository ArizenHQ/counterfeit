require 'webmock'
require 'active_support'
require 'active_support/core_ext'
require 'counterfeit/version'
require 'counterfeit/be2bill/app'
require 'counterfeit/bittrex/app'
require 'counterfeit/blockchain/app'
require 'counterfeit/dow_jones/app'
require 'counterfeit/etherchain/app'
require 'counterfeit/ledger/app'
require 'counterfeit/nexmo/app'
require 'counterfeit/slack/app'
require 'counterfeit/ripple/app'

module Counterfeit
  include WebMock::API

  module_function
  def plugins
    [
      Counterfeit::Be2Bill,
      Counterfeit::Bittrex,
      Counterfeit::Blockchain,
      Counterfeit::DowJones,
      Counterfeit::Etherchain,
      Counterfeit::Ledger,
      Counterfeit::Nexmo,
      Counterfeit::Slack,
      Counterfeit::Ripple
    ]
  end

  def self.logger
    @logger ||= Logger.new(File.join(File.expand_path(__dir__), '../log/counterfeit'))
  end

  def self.logger=(logger)
    @logger = logger
  end

  def enable!(plugins=self.plugins)
    WebMock.allow_net_connect!
    WebMock.enable!

    # https://github.com/ncr/rack-proxy#warning
    patch_streaming_response if webpack_dev_server?

    plugins.each do |plugin|
      WebMock.stub_request(:any, /#{plugin::ENDPOINT}/).to_rack(plugin::App)
    end
  end

  def disable!
    WebMock.disable!
    WebMock.reset!
  end

  def webpack_dev_server?
    defined?(Webpacker) && Webpacker.dev_server.running?
  end

  def patch_streaming_response
    # yes i know, monkey patch...
    Rack::HttpStreamingResponse.class_eval do
      def each(&block)
        response.read_body(&block)
      ensure
        session.end_request_hacked unless mocking?
      end

      protected

      def response
        if mocking? # don't use hacked net_http
          @response ||= session.request(@request)
        else
          super
        end
      end

      def mocking?
        defined?(WebMock) || defined?(FakeWeb)
      end
    end
  end
end

require 'counterfeit/railtie' if defined?(::Rails::Railtie)
