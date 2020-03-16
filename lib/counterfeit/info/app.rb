require 'counterfeit/base_app'
require 'sinatra'
require 'haml'

require 'counterfeit/nexmo/app'

module Counterfeit
  module Info
    class App < Counterfeit::BaseApp

      get '/' do
        @var = 'yup'
        haml :index
      end

    end
  end
end
