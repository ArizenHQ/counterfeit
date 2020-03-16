require 'counterfeit/base_app'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Ripple
    ENDPOINT = 'data.ripple.com'

    class App < Counterfeit::BaseApp
      register Sinatra::Contrib

      get '/v2/transactions/:hash' do
        '{
            "result": "success",
            "transaction": {
                "ledger_index": 8317037,
                "date": "2014-08-14T20:22:20+00:00",
                "hash": "03EDF724397D2DEE70E49D512AECD619E9EA536BE6CFD48ED167AE2596055C9A",
                "tx": {
                    "TransactionType": "OfferCreate",
                    "Flags": 131072,
                    "Sequence": 159244,
                    "TakerPays": {
                        "value": "0.001567373",
                        "currency": "BTC",
                        "issuer": "rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B"
                    },
                    "TakerGets": "146348921",
                    "Fee": "64",
                    "SigningPubKey": "02279DDA900BC53575FC5DFA217113A5B21C1ACB2BB2AEFDD60EA478A074E9E264",
                    "TxnSignature": "3045022100D81FFECC36A3DEF0922EB5D16F1AA5AA0804C30A18ED3B512093A75E87C81AD602206B221E22A4E3158785C109E7508624AD3DE5C0E06108D34FA709FCC9575C9441",
                    "Account": "r2d2iZiCcJmNL6vhUGFjs8U8BuUq6BnmT"
                },
                "meta": {
                    "TransactionIndex": 0,
                    "AffectedNodes": [
                        {
                            "ModifiedNode": {
                                "LedgerEntryType": "AccountRoot",
                                "PreviousTxnLgrSeq": 8317036,
                                "PreviousTxnID": "A56793D47925BED682BFF754806121E3C0281E63C24B62ADF7078EF86CC2AA53",
                                "LedgerIndex": "2880A9B4FB90A306B576C2D532BFE390AB3904642647DCF739492AA244EF46D1",
                                "PreviousFields": {
                                    "Balance": "275716601760"
                                },
                                "FinalFields": {
                                    "Flags": 0,
                                    "Sequence": 326323,
                                    "OwnerCount": 27,
                                    "Balance": "275862935331",
                                    "Account": "rfCFLzNJYvvnoGHWQYACmJpTgkLUaugLEw",
                                    "RegularKey": "rfYqosNivHQFJ6KpArouxoci3QE3huKNYe"
                                }
                            }
                        }
                    ],
                    "TransactionResult": "tesSUCCESS"
                }
            }
        }'
      end
    end
  end
end
