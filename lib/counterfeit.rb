require 'counterfeit/version'
require 'ostruct'
require 'eventmachine'
require 'thin'
require 'counterfeit/info/app'
require 'counterfeit/nexmo/app'

module Counterfeit
  module_function
  def plugins
    [
      OpenStruct.new(app: Counterfeit::Info::App,  port: 3000),
      OpenStruct.new(app: Counterfeit::Nexmo::App, port: 4567)
    ]
  end


  def run
    # Start the reactor
    EM.run do
      Counterfeit.plugins.each do |plugin|
        dispatch = Rack::Builder.app do
          map '/' do
            run plugin.app.new
          end
        end

        Rack::Server.start({
          app:     dispatch,
          server:  'thin',
          Host:    '0.0.0.0',
          Port:    plugin.port,
          signals: false,
        })
      end
    end
  end
end

