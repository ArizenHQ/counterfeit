require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Nexmo
    EndPoint = 'api.nexmo.com'

    class App < Sinatra::Base
      register Sinatra::Contrib

      get '/' do
        json({nexmo: 'ok'})
      end
    end
  end
end
