require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Kraken
    ENDPOINT = 'api.kraken.com'

    class App < Sinatra::Base
      register Sinatra::Contrib

      get '/0/public/Ticker' do
        '{
          "error":[],
          "result":{
            "XETHZEUR":{
              "a":["261.99000","50","50.000"],
              "b":["261.00000","734","734.000"],
              "c":["261.99000","0.15000000"],
              "v":["55747.22739017","75887.92474175"],
              "p":["257.21806","260.23223"],
              "t":[12966,18011],
              "l":["246.00000","246.00000"],
              "h":["268.86000","275.15000"],
              "o":"268.54000"
            },
            "XETHZUSD":{
              "a":["306.60000","94","94.000"],
              "b":["305.80000","5","5.000"],
              "c":["306.60000","0.88540000"],
              "v":["37565.21197036","48676.10118148"],
              "p":["303.94072","306.76256"],
              "t":[10301,13433],
              "l":["290.50000","290.50000"],
              "h":["317.53000","323.45000"],
              "o":"316.83000"
            },
            "XXBTZEUR":{
              "a":["4619.90000","8","8.000"],
              "b":["4619.70000","7","7.000"],
              "c":["4619.90000","0.02029000"],
              "v":["7668.12084446","8926.41172574"],
              "p":["4550.71912","4580.30673"],
              "t":[23818,29586],
              "l":["4390.40000","4390.40000"],
              "h":["4755.90000","4785.00000"],
              "o":"4755.90000"
            },
            "XXBTZUSD":{
              "a":["5440.00000","2","2.000"],
              "b":["5429.90000","2","2.000"],
              "c":["5436.00000","0.01822577"],
              "v":["4772.52650030","5404.56232732"],
              "p":["5361.32321","5389.84693"],
              "t":[14120,17031],
              "l":["5132.30000","5132.30000"],
              "h":["5606.50000","5648.60000"],
              "o":"5606.50000"
            },
            "XXRPZEUR":{
              "a":["0.77099000","328","328.000"],
              "b":["0.77018000","1618","1618.000"],
              "c":["0.77140000","30.00000000"],
              "v":["14311996.64801602","20604864.57242417"],
              "p":["0.76164867","0.74877512"],
              "t":[14733,20556],
              "l":["0.69010000","0.69010000"],
              "h":["0.80000000","0.80000000"],
              "o":"0.72227000"
              },
            "XXRPZUSD":{
              "a":["0.94469000","170","170.000"],
              "b":["0.94282000","889","889.000"],
              "c":["0.94316000","0.02204584"],
              "v":["9258198.07140281","13766250.58875794"],
              "p":["0.92366512","0.91097054"],
              "t":[7314,10607],
              "l":["0.85010000","0.85010000"],
              "h":["0.99000000","0.99000000"],
              "o":"0.88896000"
            }
          }
        }'
      end


      post '/0/private/AddOrder' do
        volume = params[:volume].to_f

        response = if volume < 0.1
          '{"error":["EOrder:Insufficient funds"]}'
        elsif volume < 0.2
          '{"error":["EAPI:Invalid nonce"]}'
        elsif volume < 0.3
          '{"error":["EService:Unavailable"]}'
        elsif volume < 0.4
          '{
            "error": [],
            "result": {
              "descr":{
                "order":"buy 0.02000000 XBTEUR @ market"
              },
              "txid":["OEYVCO-D32UE-WAKU7Z"]
            }
          }'
        elsif volume < 0.5
          '{
            "error": [],
            "result": {
              "descr":{
                "order":"buy 0.02000000 XBTEUR @ market"
              },
              "txid":["OEYVCO-D32UE-WAKU7Y"]
            }
          }'
        elsif volume > 1.0
          '{
            "error": [],
            "result": {
              "descr":{
                "order":"buy 0.02000000 XBTEUR @ market"
              },
              "txid":["OEYVCO-D32UE-WAKU7W"]
            }
          }'
        else
          '{
            "error": [],
            "result": {
              "descr":{
                "order":"buy 0.02000000 XBTEUR @ market"
              },
              "txid":["OEYVCO-D32UE-WAKU7X"]
            }
          }'
        end
      end

      post '/0/private/OpenOrders' do
        '{"error":[],"result":{"open":{}}}'
      end

      post '/0/private/ClosedOrders' do
        '{"error":[],"result":{"closed":{}}}'
      end

      post '/0/private/QueryOrders' do
        txid = params[:txid]

        response = if txid == 'OEYVCO-D32UE-WAKU7Z'
          '{"error":["Unexpected error"]}'
        elsif txid == 'OEYVCO-D32UE-WAKU7Y'
          '{
            "error":[],
            "result":{
              "WAKU7Y":{
                "refid":null,
                "userref":167503,
                "status":"open",
                "opentm":1513791896.499,
                "starttm":0,
                "expiretm":0,
                "descr":{
                  "pair":"XBTEUR",
                  "type":"buy",
                  "ordertype":"market",
                  "price":"0",
                  "price2":"0",
                  "leverage":"none",
                  "order":"buy 0.06284000 XBTEUR @ market"
                },
                "vol":"0.06284000",
                "vol_exec":"0.00000000",
                "cost":"0.00000",
                "fee":"0.00000",
                "price":"0.00000",
                "misc":"",
                "oflags":"fciq"
              }
            }
          }'
        elsif txid == 'OEYVCO-D32UE-WAKU7W'
          '{
            "error":[],
            "result":{
              "OEYVCO-D32UE-WAKU7X":{
                "refid":null,
                "userref":152384,
                "status":"cancelled",
                "reason":null,
                "opentm":1508332537.3304,
                "closetm":1508332538.2195,
                "starttm":0,
                "expiretm":0,
                "descr":{
                  "pair":"XBTEUR",
                  "type":"buy",
                  "ordertype":"market",
                  "price":"0",
                  "price2":"0",
                  "leverage":"none",
                  "order":"buy 0.02077000 XBTEUR @ market"
                },
                "vol":"1.10000000",
                "vol_exec":"0.30000000",
                "cost":"93.4",
                "fee":"0.1",
                "price":"4500.0",
                "misc":"",
                "oflags":"fciq"
              }
            }
          }'
        else
          '{
            "error":[],
            "result":{
              "OEYVCO-D32UE-WAKU7X":{
                "refid":null,
                "userref":152384,
                "status":"closed",
                "reason":null,
                "opentm":1508332537.3304,
                "closetm":1508332538.2195,
                "starttm":0,
                "expiretm":0,
                "descr":{
                  "pair":"XBTEUR",
                  "type":"buy",
                  "ordertype":"market",
                  "price":"0",
                  "price2":"0",
                  "leverage":"none",
                  "order":"buy 0.02077000 XBTEUR @ market"
                },
                "vol":"0.02077000",
                "vol_exec":"0.02077000",
                "cost":"93.4",
                "fee":"0.1",
                "price":"4500.0",
                "misc":"",
                "oflags":"fciq"
              }
            }
          }'
        end
      end

      post '/0/private/Balance' do
        json(result: {"XXBT" => 10, "XETH" => 100, "ZEUR" => 100_000})
      end
    end
  end
end
