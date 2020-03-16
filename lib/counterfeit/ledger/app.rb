require 'counterfeit/base_app'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Ledger
    ENDPOINT = 'api.ledgerwallet.com'

    class App < Counterfeit::BaseApp
      register Sinatra::Contrib

      get '/blockchain/v2/btc/transactions/:txid' do
        response = [
          {
            hash: '59e5cd400decf3f7e566818c36948fc3d9eafd18f34c6cfdd57a8b4288b63800',
            received_at: '2017-04-13T22:44:35Z',
            lock_time: 0,
            block: {
              hash: '0000000000000000011fc93bba7862fed329fe89cdb3740dae2035684ed0977d',
              height: 461767,
              time: '2017-04-13T22:44:35Z'
            },
            inputs: [
              {
                input_index: 0,
                output_hash: 'b914cd6d1c6bb26aa1953733b2628127220afb8d4929e8ae38d5ef83751c7111',
                output_index: 1,
                value: 1625561173,
                address: '1LMLpNm19HoJgUM1MfZy6okEUHhAyuu4Zr',
                script_signature: '483045022100968fb9c8e60c52becc1d6453e77637172626d4cb1a8034493edf3c92f15fe93a02205d00874b3f4e4a8ecc73d199e1aacdad78220cc869c98e62b45247bab1890352012102186a40100380429187f00fda54b62be6fbb1813ea2ff335f3603a69fbdee5637'
              }
            ],
            outputs: [
              {
                output_index: 0,
                value: 1695000,
                address: '1LMLpNm19HoJgUM1MfZy6okEUHhAyuu4Zr',
                script_hex: 'a914a6277002b96f196fbe298f02e5cefccc2426acc387'
              }
            ],
            fees: 73664,
            amount: 1625487509,
            confirmations: 38640
          }
        ]

        json(response)
      end

      post '/blockchain/v2/btc/transactions/send' do
        json(txid: SecureRandom.hex)
      end

      get '/blockchain/v2/btc/fees' do
        '{"1":461353,"3":418502,"6":418502,"last_updated":1515401170}'
      end

      get '/wallet/:currency/balance' do
        json(balance: 100)
      end

      post '/wallet/:currency/send' do |currency|
        multiplier = currency == 'btc' ? 1 : 10
        params[:amount].to_f.round(2) == 0.11 * multiplier ? json(error: 'Some error') : json(txid: SecureRandom.hex)
      end

      get '/wallet/btc/new_address' do
        json(address: '1LMLpNm19HoJgUM1MfZy6okEUHhAyuu4Zr')
      end
    end
  end
end
