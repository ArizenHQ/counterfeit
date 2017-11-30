require 'sinatra/base'
require 'haml'

module Counterfeit
  module Info
    class App < Sinatra::Base
      set :bind, '0.0.0.0'
      set :port, '4567'

      get '/' do
        @var = 'yup'
        haml :index
      end
    end
  end
end
