require 'counterfeit/base_app'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Blockchain
    ENDPOINT = 'blockchain.info'

    class App < Counterfeit::BaseApp
      register Sinatra::Contrib

      get '/ticker' do
        '{
          "USD" : {"15m" : 16170.64, "last" : 16170.64, "buy" : 16175.47, "sell" : 16165.81, "symbol" : "$"},
          "AUD" : {"15m" : 21044.54, "last" : 21044.54, "buy" : 21050.82, "sell" : 21038.25, "symbol" : "$"},
          "BRL" : {"15m" : 53445.83, "last" : 53445.83, "buy" : 53461.79, "sell" : 53429.86, "symbol" : "R$"},
          "CAD" : {"15m" : 20625.6, "last" : 20625.6, "buy" : 20631.76, "sell" : 20619.44, "symbol" : "$"},
          "CHF" : {"15m" : 16006.69, "last" : 16006.69, "buy" : 16011.47, "sell" : 16001.9, "symbol" : "CHF"},
          "CLP" : {"15m" : 1.002660533E7, "last" : 1.002660533E7, "buy" : 1.002960017E7, "sell" : 1.002361049E7, "symbol" : "$"},
          "CNY" : {"15m" : 109610.96, "last" : 109610.96, "buy" : 112889.73, "sell" : 106332.19, "symbol" : "¥"},
          "DKK" : {"15m" : 101515.71, "last" : 101515.71, "buy" : 101546.03, "sell" : 101485.38, "symbol" : "kr"},
          "EUR" : {"15m" : 13739.83, "last" : 13739.83, "buy" : 13763.49, "sell" : 13716.16, "symbol" : "€"},
          "GBP" : {"15m" : 12110.76, "last" : 12110.76, "buy" : 12114.38, "sell" : 12107.14, "symbol" : "£"},
          "HKD" : {"15m" : 126482.54, "last" : 126482.54, "buy" : 126520.32, "sell" : 126444.76, "symbol" : "$"},
          "INR" : {"15m" : 1035102.08, "last" : 1035102.08, "buy" : 1035411.25, "sell" : 1034792.9, "symbol" : "₹"},
          "ISK" : {"15m" : 1705032.29, "last" : 1705032.29, "buy" : 1705541.56, "sell" : 1704523.01, "symbol" : "kr"},
          "JPY" : {"15m" : 1833665.68, "last" : 1833665.68, "buy" : 1834213.38, "sell" : 1833117.98, "symbol" : "¥"},
          "KRW" : {"15m" : 1.745895488E7, "last" : 1.745895488E7, "buy" : 1.746416969E7, "sell" : 1.745374008E7, "symbol" : "₩"},
          "NZD" : {"15m" : 23064.59, "last" : 23064.59, "buy" : 23071.48, "sell" : 23057.7, "symbol" : "$"},
          "PLN" : {"15m" : 57268.37, "last" : 57268.37, "buy" : 57285.48, "sell" : 57251.26, "symbol" : "zł"},
          "RUB" : {"15m" : 944967.73, "last" : 944967.73, "buy" : 945249.98, "sell" : 944685.48, "symbol" : "RUB"},
          "SEK" : {"15m" : 136098.49, "last" : 136098.49, "buy" : 136139.14, "sell" : 136057.84, "symbol" : "kr"},
          "SGD" : {"15m" : 21755.2, "last" : 21755.2, "buy" : 21761.7, "sell" : 21748.7, "symbol" : "$"},
          "THB" : {"15m" : 529580.37, "last" : 529580.37, "buy" : 529738.55, "sell" : 529422.19, "symbol" : "฿"},
          "TWD" : {"15m" : 484389.66, "last" : 484389.66, "buy" : 484534.34, "sell" : 484244.98, "symbol" : "NT$"}
        }'
      end

      post '/merchant/:guid/payment' do
        amount = params[:amount].to_f
        if (amount / 10**8).round(2) == 0.11
          status 500
          '{"error":"Error signing and pushing transaction"}'
        else
          "{
            \"to\":[\"3GqZLZCjp6czv2PUCw6UXXqu4FjAtKtqHy\"],
            \"amounts\":[1695000],
            \"from\":[\"xpub6CThYZbX4PTeA7KRYZ8YXP3F6HwT2eVKPQap3Avieds3p1eos35UzSsJtTbJ3vQ8d3fjRwk4bCEz4m4H6mkFW49q29ZZ6gS8tvahs4WCZ9X\"],
            \"fee\":73664,
            \"txid\":\"#{SecureRandom.hex}\",
            \"tx_hash\":\"59e5cd400decf3f7e566818c36948fc3d9eafd18f34c6cfdd57a8b4288b63800\",
            \"message\":\"Payment Sent\",
            \"success\":true
          }"
        end
      end

      get '/fr/rawtx/:txid' do
        if params[:format] == 'hex'
          '010000000111711c7583efd538aee829498dfb0a22278162b2333795a16ab26b1c6dcd14b9010000006b483045022100968fb9c8e60c52becc1d6453e77637172626d4cb1a8034493edf3c92f15fe93a02205d00874b3f4e4a8ecc73d199e1aacdad78220cc869c98e62b45247bab1890352012102186a40100380429187f00fda54b62be6fbb1813ea2ff335f3603a69fbdee5637ffffffff0218dd19000000000017a914a6277002b96f196fbe298f02e5cefccc2426acc3877d1bc960000000001976a914e06f76a72a32dd51c64eeded38789ea1222645e288ac00000000'
        else
          '{"ver"=>1, "inputs"=>[{"sequence"=>4294967295, "witness"=>"", "prev_out"=>{"spent"=>true, "tx_index"=>241112679, "type"=>0, "addr"=>"123aBD6AkRMh9FiwQPgG1nsMeJLFVpWKwV", "value"=>1625561173, "n"=>1, "script"=>"76a9140b74a6d21f99bcd2ae5bf2327fa1f1faa1a3a3d588ac"}, "script"=>"483045022100968fb9c8e60c52becc1d6453e77637172626d4cb1a8034493edf3c92f15fe93a02205d00874b3f4e4a8ecc73d199e1aacdad78220cc869c98e62b45247bab1890352012102186a40100380429187f00fda54b62be6fbb1813ea2ff335f3603a69fbdee5637"}], "weight"=>896, "block_height"=>461767, "relayed_by"=>"127.0.0.1", "out"=>[{"spent"=>true, "tx_index"=>241111683, "type"=>0, "addr"=>"3GqZLZCjp6czv2PUCw6UXXqu4FjAtKtqHy", "value"=>1695000, "n"=>0, "script"=>"a914a6277002b96f196fbe298f02e5cefccc2426acc387"}, {"spent"=>true, "tx_index"=>241111683, "type"=>0, "addr"=>"1MThtbADxpGDADuh6hrXiD6WCtdHLQkgvN", "value"=>1623792509, "n"=>1, "script"=>"76a914e06f76a72a32dd51c64eeded38789ea1222645e288ac"}], "lock_time"=>0, "size"=>224, "double_spend"=>false, "time"=>1492123316, "tx_index"=>241111683, "vin_sz"=>1, "hash"=>"59e5cd400decf3f7e566818c36948fc3d9eafd18f34c6cfdd57a8b4288b63800", "vout_sz"=>2}'
        end
      end

      get '/merchant/:guid/accounts/:account/receiveAddress' do
        json(address: '1LMLpNm19HoJgUM1MfZy6okEUHhAyuu4Zr')
      end
    end
  end
end
