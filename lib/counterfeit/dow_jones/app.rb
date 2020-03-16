require 'counterfeit/base_app'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module DowJones
    ENDPOINT = 'https://djrc.api.dowjones.com'.freeze

    class App < Counterfeit::BaseApp
      register Sinatra::Contrib

      get '/v1/search/name' do
        if params[:name] == 'Donald TRUMP'
          {
            body: {
              match: [{
                peid: '1143233',
                match_type: 'PRECISE',
                score: '1.0',
                payload: {
                  'risk-icons' => {
                    'risk-icon' => 'PEP'
                  },
                  title: 'President of the United States'
                }
              }, {
                peid: '1143243',
                match_type: 'PRECISE',
                score: '1.0',
                payload: {
                  'risk-icons' => {
                    'risk-icon' => 'RCA'
                  },
                  title: nil
                }
              }]
            }
          }.to_xml(root: 'search-results')
        elsif params[:name] == 'Ibrahima SOUMAR'
          {
            body: {
              match: [{
                peid: '1448898',
                match_type: 'NEAR',
                score: '0.7714286',
                payload: {
                  'risk-icons' => {
                    'risk-icon' => 'PEP'
                  },
                  title: 'Adviser, Ministry of National Defence'
                }
              }, {
                peid: '2863409',
                match_type: 'BROAD',
                score: '0.6322848',
                payload: {
                  'risk-icons' => {
                    'risk-icon' => 'SI'
                  },
                  title: 'See Previous Roles'
                }
              }]
            }
          }.to_xml(root: 'search-results')
        elsif params[:name] == 'Mohammed IDRIS'
          {
            body: {
              match: [{
                peid: '938515',
                match_type: 'NEAR',
                score: '0.95714283',
                payload: {
                  'risk-icons' => {
                    'risk-icon' => 'OOL'
                  },
                  title: 'Central Bureau of Investigation (India) Wanted List'
                }
              }]
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
