require 'counterfeit/base_app'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Bittrex
    ENDPOINT = 'bittrex.com'

    class App < Counterfeit::BaseApp
      register Sinatra::Contrib

      get '/api/v1.1/account/getbalances' do
        '{
          "success" : true,
          "message" : "",
          "result" : [{
              "Currency" : "DOGE",
              "Balance" : 0.00000000,
              "Available" : 0.00000000,
              "Pending" : 0.00000000,
              "CryptoAddress" : "DLxcEt3AatMyr2NTatzjsfHNoB9NT62HiF",
              "Requested" : false,
              "Uuid" : null

            }, {
              "Currency" : "BTC",
              "Balance" : 14.21549076,
              "Available" : 14.21549076,
              "Pending" : 0.00000000,
              "CryptoAddress" : "1Mrcdr6715hjda34pdXuLqXcju6qgwHA31",
              "Requested" : false,
              "Uuid" : null
            }, {
              "Currency" : "XRP",
              "Balance" : 0.00000000,
              "Available" : 0.00000000,
              "Pending" : 0.00000000,
              "CryptoAddress" : "rPVMhWBsfF9iMXYj3aAzJVkPDTFNSyWdKy",
              "Requested" : false,
              "Uuid" : null
            }
          ]
        }'
      end
    end
  end
end
