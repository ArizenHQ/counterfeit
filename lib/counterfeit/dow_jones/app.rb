require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module DowJones
    ENDPOINT = 'https://djrc.api.dowjones.com'.freeze

    class App < Sinatra::Base
      register Sinatra::Contrib

      get '/v1/search/name' do
        if params[:name] == 'Donald TRUMP'
          {
            body: {
              match: {
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
          }.to_xml(root: 'search-results')
        else
          {
            body: {}
          }.to_xml(root: 'search-results').squish.tr('\n ', '')
        end
      end
    end
  end
end
