require 'counterfeit/base_app'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Slack
    ENDPOINT = 'hooks.slack.com'

    class App < Counterfeit::BaseApp
      register Sinatra::Contrib

      post '/services/:some/:postfix' do
        json({})
      end
    end
  end
end
