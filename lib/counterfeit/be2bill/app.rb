require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Be2Bill
    EndPoint = 'secure-test.be2bill.com'

    class App < Sinatra::Base
      register Sinatra::Contrib


      post '/front/service/rest/process.php' do
        response = if params[:AMOUNT] < 10000
          { 'EXECCODE' => '5004' }
        elsif params[:AMOUNT].between?(10000, 20000)
          { 'EXECCODE' => '5002' }
        else
          { 'EXECCODE' => '0000' }
        end

        json(response)
      end
    end
  end
end
