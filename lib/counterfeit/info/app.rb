require 'sinatra/base'
require 'haml'

module Counterfeit
  module Info
    class App < Sinatra::Base
      configure do
        set :threaded, false
      end

      get '/' do
        @var = 'yup'
        haml :index
      end
    end
  end
end
