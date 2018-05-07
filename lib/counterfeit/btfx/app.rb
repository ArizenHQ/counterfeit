require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Btfx
    ENDPOINT = 'api.bitfinex.com'

    class App < Sinatra::Base
      register Sinatra::Contrib

      post '/v1/balances' do
        response = wallet_ballances

        json(response)
      end

      post '/v1/order/new' do
        response =
          if payload['amount'] == '50'
            status 400
            { message: 'Invalid order: not enough tradable balance.' }
          elsif payload['side'] == 'sell'
            new_order_response('sell')
          else
            new_order_response
          end

        json(response)
      end

      post '/v1/order/cancel' do
        response =
          if payload['order_id'] == 448364249
            status 400
            { message: 'Order could not be cancelled.' }
          else
            cancel_order_response
          end

        json(response)
      end

      post '/v1/order/status' do
        response =
          if payload['order_id'] == 448411153
            status 400
            { message: 'No such order found.' }
          else
            order_status_response
          end

        json(response)
      end

      get '/v1/pubticker/btcusd' do
        response = btc_usd_pair

        json(response)
      end

      get '/v1/pubticker/btceur' do
        response = btc_eur_pair

        json(response)
      end

      get '/v1/pubticker/ethusd' do
        response = eth_usd_pair

        json(response)
      end

      get '/v1/pubticker/etheur' do
        response = eth_eur_pair

        json(response)
      end

      get '/v1/pubticker/aaabbb' do
        response = invalid_pair

        json(response)
      end

      private

      def wallet_ballances
        [
          { 'type' => 'deposit',  'currency' => 'btc', 'amount' => '0.0', 'available' => '0.0' },
          { 'type' => 'deposit',  'currency' => 'eth', 'amount' => '0.0', 'available' => '0.0' },
          { 'type' => 'deposit',  'currency' => 'eur', 'amount' => '1.0', 'available' => '1.0' },
          { 'type' => 'exchange', 'currency' => 'btc', 'amount' => '1',   'available' => '1' },
          { 'type' => 'exchange', 'currency' => 'eth', 'amount' => '1',   'available' => '1' },
          { 'type' => 'exchange', 'currency' => 'eur', 'amount' => '1',   'available' => '1' },
          { 'type' => 'trading',  'currency' => 'btc', 'amount' => '1',   'available' => '1' },
          { 'type' => 'trading',  'currency' => 'eth', 'amount' => '1',   'available' => '1' },
          { 'type' => 'trading',  'currency' => 'eur', 'amount' => '1',   'available' => '1' }
       ]
      end

      def new_order_response(type = 'buy')
        {
          'id' => '448364249',
          'symbol' => 'btceur',
          'exchange' => 'bitfinex',
          'price' => '0.01',
          'avg_execution_price' => '0.0',
          'side' => type,
          'type' => 'exchange limit',
          'timestamp' => '1524206467.252370982',
          'is_live' => 'true',
          'is_cancelled' => 'false',
          'is_hidden' => 'false',
          'was_forced' => 'false',
          'original_amount' => '0.01',
          'remaining_amount' => '0.01',
          'executed_amount' => '0.0',
          'order_id' => '448364249'
        }
      end

      def cancel_order_response
        {
          'id' => '446915287',
          'symbol' => 'btceur',
          'exchange' => 'null',
          'price' => '239.0',
          'avg_execution_price' => '0.0',
          'side' => 'sell',
          'type' => 'trailing stop',
          'timestamp' => '1444141982.0',
          'is_live' => 'true',
          'is_cancelled' => 'false',
          'is_hidden' => 'false',
          'was_forced' => 'false',
          'original_amount' => '1.0',
          'remaining_amount' => '1.0',
          'executed_amount' => '0.0'
        }
      end

      def order_status_response
        {
          'id' => '448411153',
          'symbol' => 'btceur',
          'exchange' => 'null',
          'price' => '0.01',
          'avg_execution_price' => '0.0',
          'side' => 'buy',
          'type' => 'exchange limit',
          'timestamp' => '1444276570.0',
          'is_live' => 'false',
          'is_cancelled' => 'true',
          'is_hidden' => 'false',
          'oco_order' => 'null',
          'was_forced' => 'false',
          'original_amount' => '0.01',
          'remaining_amount' => '0.01',
          'executed_amount' => '0.0'
        }
      end

      def btc_usd_pair
        {
          'mid' => '9360.05',
          'bid' => '9360.0',
          'ask' => '9360.1',
          'last_price' => '9360.0',
          'low' => '9259.4',
          'high' => '9725.0',
          'volume' => '26444.135191689995',
          'timestamp' => '1525678028.914629'
        }
      end

      def btc_eur_pair
        {
          'mid' => '7844.6',
          'bid' => '7844.5',
          'ask' => '7844.7',
          'last_price' => '7843.9174424',
          'low' => '7730.5',
          'high' => '8126.385696',
          'volume' => '1791.72801759',
          'timestamp' => '1525678038.911444'
        }
      end

      def eth_usd_pair
        {
          'mid' => '744.325',
          'bid' => '744.27',
          'ask' => '744.38',
          'last_price' => '744.24',
          'low' => '741.0',
          'high' => '800.85',
          'volume' => '237367.73164226004',
          'timestamp' => '1525678537.5447907'
        }
      end

      def eth_eur_pair
        {
          'mid' => '620.525',
          'bid' => '620.29',
          'ask' => '620.76',
          'last_price' => '620.863122',
          'low' => '620.0',
          'high' => '670.97',
          'volume' => '5306.78267907',
          'timestamp' => '1525678608.786321'
        }
      end

      def invalid_pair
        {
          'message' => 'Unknown symbol'
        }
      end

      def payload
        JSON.parse(Base64.decode64(@env['HTTP_X_BFX_PAYLOAD']))
      end
    end
  end
end
