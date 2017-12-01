require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Nexmo
    EndPoint = 'api.nexmo.com'

    class App < Sinatra::Base
      register Sinatra::Contrib


      post '/verify/json' do
        response = if params[:number].blank?
          { status: '2', error_text: 'Your request is incomplete and missing the mandatory parameter: number' }
        elsif params[:number] == '+33622222222'
          { status: '10', error_text: 'Concurrent verifications to the same number are not allowed' }
        else
          { status:'0', request_id:'8131d41d6f564837baf8037452131d34' }
        end

        json(response)
      end


      post '/verify/check/json' do
        response = if params[:code].blank? || params[:request_id].blank?
          { status: '2', error_text: 'Your request is incomplete and missing the mandatory parameter' }
        elsif params[:code] == '2222'
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
    end
  end
end
