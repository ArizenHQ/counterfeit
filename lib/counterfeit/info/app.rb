require 'sinatra/base'
require 'haml'

module Counterfeit
  module Info
    ENDPOINT = '0.0.0.0:4567'.freeze
    class App < Sinatra::Base

      get '/' do
        @var = 'yup'
        haml :index
      end
    end
  end
end
