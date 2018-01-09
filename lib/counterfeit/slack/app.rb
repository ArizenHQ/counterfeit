require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Slack
    EndPoint = 'hooks.slack.com'

    class App < Sinatra::Base
      register Sinatra::Contrib

      post '/services/:some/:postfix' do
        json({})
      end
    end
  end
end
