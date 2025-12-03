require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Example
    ENDPOINT = 'www.example.com'.freeze
    # If you have several endpoints matching the same app, you can stub them all
    ENDPOINTS = %w(www.example2.com www.example3.com).freeze

    class App < Sinatra::Base
      register Sinatra::Contrib

      get '/test' do
        json({ result: 'ok' })
      end
    end
  end
end
