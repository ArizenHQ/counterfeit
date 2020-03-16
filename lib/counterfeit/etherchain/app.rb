require 'counterfeit/base_app'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Etherchain
    ENDPOINT = 'www.etherchain.org'

    class App < Counterfeit::BaseApp
      register Sinatra::Contrib

      get '/api/tx/:txid' do
        response = [
          {
            hash: '69a757ff27c8712eeeb104a810a4045291bfd1801a1d4fc705b6fa98ac3efdce',
            parenthash: '69a757ff27c8712eeeb104a810a4045291bfd1801a1d4fc705b6fa98ac3efdce',
            from: '196a45b7a2a06ca4876826f4eaf54c6b0ff87a60',
            to: 'cd20fac6472f9cb1ed3b7fcb5823d2e3f8c08fdc',
            gasprice: '21000000000',
            gas: '21000',
            value: '4000000000000000000',
            blocknumber: 3388168,
            blockhash: '0a0d45f9c1d6d42b58673e6e4bc0eeec84bf2734ab3b5a091dd76b955a4a74dc',
            time: '2017-03-20T20:24:42.000Z',
            createscontract: false,
            invokescontract: false,
            txindex: 1,
            itxindex: -1,
            gasused: '21000',
            failed: false,
            errormsg: '',
            input: '',
            type: 'tx',
            isspam: false,
            nonce: 1
          }
        ]

        json(response)
      end

      get '/api/blocks/count' do
        json(count: 4873342)
      end
    end
  end
end
