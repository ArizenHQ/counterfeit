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

    end
  end
end
