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
          if params[:amount] == 50
            { status: 400, message: 'Invalid order: not enough tradable balance.' }
          elsif params[:side] == 'sell'
            new_order_response('sell')
          else
            new_order_response
          end

        json(response)
      end

      post '/v1/order/cancel' do
        response =
          if params[:order_id] == '448364249'
            { status: 400, message: 'Order could not be cancelled.' }
          else
            cancel_order_response
          end

        json(response)
      end

      post '/v1/order/status' do
        response =
          if params[:order_id] == '448411153'
            { status: 400, message: 'No such order found.' }
          else
            order_status_response
          end

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
    end
  end
end
