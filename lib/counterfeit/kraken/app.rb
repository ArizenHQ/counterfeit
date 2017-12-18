require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Kraken
    EndPoint = 'api.kraken.com'

    class App < Sinatra::Base
      register Sinatra::Contrib


      post '/0/private/AddOrder' do
        response =
          case params[:volume]
          when 0.01
            { error: ['EOrder:Insufficient funds'] }
          when 0.02
            { error: ['EAPI:Invalid nonce'] }
          when 0.03
            { error: ['EService:Unavailable'] }
          when 0.04
            { error: [], result: { descr: { order: 'buy 0.02000000 XBTEUR @ market' }, txid: ['OEYVCO-D32UE-WAKU7Z'] } }
          else
            { error: [], result: { descr: { order: 'buy 0.02000000 XBTEUR @ market' }, txid: ['OEYVCO-D32UE-WAKU7X'] } }
          end

        json(response)
      end

      post '/0/private/OpenOrders' do
        json({ error: [], result: { open: [] } })
      end

      post '/0/private/ClosedOrders' do
        json({ error: [], result: { closed: [] } })
      end

      post '0/private/QueryTrades' do
        response = if params[:txid] == 'OEYVCO-D32UE-WAKU7Z'
          { error: ['Some error'] }
        else
          {
            error: [],
            result: {
              'OEYVCO-D32UE-WAKU7X' => {
                refid: nil,
                userref: nil,
                status: 'closed',
                reason: nil,
                opentm: 1401119612.5818,
                closetm: 1401119612.5877,
                starttm: '0',
                expiretm: '0',
                vol: '0.02000000',
                vol_exec: '0.02000000',
                cost: '8.54538',
                fee: '0.01624',
                price: '427.26900',
                misc: '',
                oflags: '',
                descr: {
                  pair: 'XBTEUR',
                  type: 'buy',
                  ordertype: 'market',
                  price: '0',
                  price2: '0',
                  leverage: 'none',
                  order: 'buy 0.02000000 XBTEUR @ market'
                }
              }
            }
          }

          json(response)
        end
      end
    end
  end
end
