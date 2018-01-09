require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Be2Bill
    EndPoint = 'secure-test.be2bill.com'

    class App < Sinatra::Base
      register Sinatra::Contrib

      post '/front/service/rest/process.php' do
        response = if params[:params][:TRANSACTIONID] == 'B37352344'
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '5004' }
        elsif params[:params][:TRANSACTIONID] == 'B37352345'
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '5002' }
        elsif params[:params][:TRANSACTIONID] == 'B37352343'
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '5001' }
        else
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '0000' }
        end

        json(response)
      end
    end
  end
end
