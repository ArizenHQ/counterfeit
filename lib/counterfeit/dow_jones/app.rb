require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module DowJones
    ENDPOINT = 'https://djrc.api.dowjones.com'.freeze

    class App < Sinatra::Base
      register Sinatra::Contrib

      get '/v1/search/name' do
        response =
          if params[:name] == 'Donald TRUMP'
            {
              body: {
                peid: '1143233',
                match_type: 'PRECISE',
                score: '1.0',
                payload: {
                  'risk-icons' => {
                    'risk-icon' => 'PEP'
                  },
                  title: 'President of the United States'
                }
              }
            }
          else
            {
              body: {}
            }
          end
        response.to_xml(root: 'search-results').squish.tr('\n ', '')
      end
    end
  end
end
