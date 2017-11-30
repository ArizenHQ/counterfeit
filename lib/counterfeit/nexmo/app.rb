require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Nexmo
    class App < Sinatra::Base
      register Sinatra::Contrib

      configure do
        set :threaded, false
      end

      get '/' do
        json({nexmo: 'ok'})
      end
    end
  end
end
