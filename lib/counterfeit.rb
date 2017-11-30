require 'webmock'
require 'active_support'
require 'active_support/core_ext'
require 'counterfeit/version'
require 'counterfeit/nexmo/app'

module Counterfeit
  include WebMock::API

  module_function
  def plugins
    [
      Counterfeit::Nexmo
    ]
  end


  def enable!
    WebMock.enable!
    WebMock.allow_net_connect!

    plugins.each do |plugin|
      WebMock.stub_request(:any, /#{plugin::EndPoint}/).to_rack(plugin::App)
    end
  end

  def disable!
    WebMock.disable!
    WebMock.reset!
  end
end

