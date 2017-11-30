require 'counterfeit/version'
require 'webmock'
require 'counterfeit/nexmo/app'

module Counterfeit
  include WebMock::API

  module_function
  def plugins
    [
      Counterfeit::Nexmo
    ]
  end


  def run
    WebMock.enable!
    WebMock.allow_net_connect!

    plugins.each do |plugin|
      WebMock.stub_request(:any, /#{plugin::EndPoint}/).to_rack(plugin::App)
    end
  end
end

