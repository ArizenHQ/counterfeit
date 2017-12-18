require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Blockchain
    EndPoint = 'api.blockchain.info'

    class App < Sinatra::Base
      register Sinatra::Contrib


      post '/v2/merchant/:guid/sendmany' do
        response = if params[:amount] < 0.01 * 100000000
          { message: 'Some error' }
        elsif params[:amount] < 0.02 * 100000000
          { message: 'Sent To Multiple Recipients', tx_hash: 'f322d01ad784e5deeb25464a5781c3b20971c1863679ca506e702e3e33c18e9d' }
        else
          { message: 'Sent To Multiple Recipients', tx_hash: 'f322d01ad784e5deeb25464a5781c3b20971c1863679ca506e702e3e33c18e9c' }
        end

        json(response)
      end

      get '/v2/:currency/transactions/:txid' do
        response = if params[:txid] == 'f322d01ad784e5deeb25464a5781c3b20971c1863679ca506e702e3e33c18e9d'
          [{ txid: 'f322d01ad784e5deeb25464a5781c3b20971c1863679ca506e702e3e33c18e9d', confirmations: 1 }]
        else
          []
        end
      end
    end
  end
end
