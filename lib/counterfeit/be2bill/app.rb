require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Be2Bill
    ENDPOINT = 'secure-test.be2bill.com'

    class App < Sinatra::Base
      register Sinatra::Contrib

      post %r{/front/service/rest/process} do
        response =
          if params[:method] == 'capture'
            handle_capture
          elsif params[:method] == 'authorization' && params[:params][:CREATEALIAS].present?
            handle_card_storage
          else
            handle_authorization
          end

        json(response)
      end

      private

      def handle_capture
        if params[:params][:TRANSACTIONID] == 'B37352344'
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '5004' }
        elsif params[:params][:TRANSACTIONID] == 'B37352345'
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '5002' }
        elsif params[:params][:TRANSACTIONID] == 'B37352343'
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '5001' }
        else
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '0000' }
        end
      end

      def handle_authorization
        if params[:params][:AMOUNT].to_f == 100_00
          { 'OPERATIONTYPE' => 'authorization', 'EXECCODE' => '5001', 'MESSAGE' => 'Exchange protocol failure.' }
        else
          { 'OPERATIONTYPE' => 'authorization', 'EXECCODE' => '0000', 'MESSAGE' => 'Operation succeeded.', 'TRANSACTIONID' => 'B11499474' }
        end
      end

      def handle_card_storage
        if params[:params][:CARDFULLNAME] == 'Wrong name'
          { 'OPERATIONTYPE' => 'authorization', 'EXECCODE' => '5001', 'MESSAGE' => 'Exchange protocol failure.' }
        else
          { 'OPERATIONTYPE' => 'authorization', 'EXECCODE' => '0000', 'MESSAGE' => 'Operation succeeded.', 'TRANSACTIONID' => 'B11499475', 'DESCRIPTOR' => 'RENTABILITEST', 'ALIAS' => 'A1-1d252795-1084-4bb5-8260-766bc76d2f6b' }
        end
      end
    end
  end
end
