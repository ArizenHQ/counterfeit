require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'
require 'securerandom'
require 'digest'

module Counterfeit
  module MBTC
    ENDPOINT = 'm.mbtc.fr'

    class App < Sinatra::Base
      register Sinatra::Contrib

      get "/v1/wallets/btc/receive_address" do
        '{ "result": "3GqZLZCjp6czv2PUCw6UXXqu4FjAtKtqHy" }'
      end

      get "/v1/wallets/eth/receive_address" do
        address = Digest::SHA1.hexdigest(SecureRandom.hex)

        "{ 'result': '0x#{address}' }".to_json
      end

      get '/v1/wallets/btc/balance' do
        json(result: '10')
      end

      get '/v1/wallets/eth/balance' do
        json(result: '100')
      end

      post '/v1/wallets/:currency/pay' do |currency|
        multiplier = currency == 'btc' ? 1 : 10
        if params[:amount].to_f.round(2) == 0.11 * multiplier
          json(status: 'KO', message: 'Some error')
        else
          json(status: 'OK', result: SecureRandom.hex)
        end
      end
    end
  end
end
