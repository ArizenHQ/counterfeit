require 'webmock'
require 'active_support'
require 'active_support/core_ext'
require 'counterfeit/version'
require 'counterfeit/nexmo/app'
require 'counterfeit/kraken/app'
require 'counterfeit/be2bill/app'
require 'counterfeit/blockchain/app'
require 'counterfeit/ledger/app'
require 'counterfeit/etherchain/app'
require 'counterfeit/slack/app'

module Counterfeit
  include WebMock::API

  module_function
  def plugins
    [
      Counterfeit::Nexmo,
      Counterfeit::Kraken,
      Counterfeit::Be2Bill,
      Counterfeit::Blockchain,
      Counterfeit::Ledger,
      Counterfeit::Etherchain,
      Counterfeit::Slack
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
