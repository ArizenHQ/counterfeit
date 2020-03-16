require 'counterfeit/base_app'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Nexmo
    ENDPOINT = 'api.nexmo.com'

    class App < Counterfeit::BaseApp
      register Sinatra::Contrib


      post '/verify/json' do
        response = if params[:number].blank?
          { status: '2', error_text: 'Your request is incomplete and missing the mandatory parameter: number' }
        elsif params[:number] == '+33622222222'
          { status: '10', error_text: 'Concurrent verifications to the same number are not allowed' }
        elsif params[:number] =~ /8888888/
          { status: '4', error_text: 'The supplied API key or secret in the request is either invalid or disabled' }
        else
          { status:'0', request_id:'8131d41d6f564837baf8037452131d34' }
        end

        json(response)
      end


      post '/verify/check/json' do
        response = if params[:code].blank? || params[:request_id].blank?
          { status: '2', error_text: 'Your request is incomplete and missing the mandatory parameter' }
        elsif params[:code] == '2222' || params[:code] == '1111'
          { status: '16', error_text: 'The code inserted does not match the expected value' }
        elsif params[:code] == '3333'
          { status: '17', error_text: 'The wrong code was provided too many times' }
        else
          {
            request_id: params[:request_id],
            status:'0',
            event_id:'00000000001',
            price:'0.10000000',
            currency:'EUR'
          }
        end

        json(response)
      end

      get '/verify/search/json' do
        response = {
          'request_id' => params[:request_id],
          'number'     => '337700900000',
          'account_id' => 'abcdef01',
          'price'      => '0.10000000',
          'currency'   => 'EUR',
          'sender_id'  => 'Coinhouse SAS'
        }

        response['status'] =
          case params[:request_id]
          when 'in_progress', '8131d41d6f564837baf8037452131d34'
            'IN PROGRESS'
          when 'success'
            'SUCCESS'
          when 'failed'
            'FAILED'
          when 'expired'
            'EXPIRED'
          when 'cancelled'
            'FAILED'
          when 'invalid'
            '101'
          end

        json(response)
      end

    end
  end
end
