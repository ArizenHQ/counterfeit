require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Coinhouse
    ENDPOINT = 'm.mbtc.fr'

    class App < Sinatra::Base
      register Sinatra::Contrib

      get '/v1/wallets/btc/receive_address' do
        json(result: '1LMLpNm19HoJgUM1MfZy6okEUHhAyuu4Zr')
      end
    end
  end
end
