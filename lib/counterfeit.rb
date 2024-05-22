require 'webmock'
require 'active_support'
require 'active_support/core_ext'
require 'counterfeit/version'
require 'counterfeit/info/app'

module Counterfeit
  include WebMock::API

  module_function
  def plugins
    [Counterfeit::Info]
  end

  # Enable Webmock and stub provided plugins.
  def enable!(plugins = self.plugins)
    WebMock.enable!

    stub_plugins(plugins)

    # https://github.com/ncr/rack-proxy#warning
    patch_streaming_response if webpack_dev_server?
  end

  # Only stub provided plugins (when WebMock is setup outside Counterfeit for example).
  def stub_plugins(plugins)
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
