require 'webmock'
require 'active_support'
require 'active_support/core_ext'
require 'counterfeit/version'
require 'counterfeit/be2bill/app'
require 'counterfeit/blockchain/app'
require 'counterfeit/dow_jones/app'
require 'counterfeit/etherchain/app'
require 'counterfeit/kraken/app'
require 'counterfeit/ledger/app'
require 'counterfeit/nexmo/app'
require 'counterfeit/slack/app'
require 'counterfeit/coinhouse/app'

module Counterfeit
  include WebMock::API

  module_function
  def plugins
    [
      Counterfeit::Be2Bill,
      Counterfeit::Blockchain,
      Counterfeit::DowJones,
      Counterfeit::Etherchain,
      Counterfeit::Kraken,
      Counterfeit::Ledger,
      Counterfeit::Nexmo,
      Counterfeit::Slack,
      Counterfeit::Coinhouse
    ]
  end


  def enable!(plugins=self.plugins)
    WebMock.enable!
    WebMock.allow_net_connect!

    plugins.each do |plugin|
      WebMock.stub_request(:any, /#{plugin::ENDPOINT}/).to_rack(plugin::App)
    end
  end

  def disable!
    WebMock.disable!
    WebMock.reset!
  end
end
