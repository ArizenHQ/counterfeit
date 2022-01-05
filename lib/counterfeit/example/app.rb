require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Example
    ENDPOINT = 'www.example.com'

    class App < Sinatra::Base
      register Sinatra::Contrib

      get '/test' do
        json({ result: 'ok' })
      end
    end
  end
end