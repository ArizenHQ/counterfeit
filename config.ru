$LOAD_PATH << File.expand_path('lib', __dir__)

require 'sinatra/base'
require 'byebug'

require 'counterfeit'
require 'counterfeit/bittrex/app'
require 'counterfeit/blockchain/app'
require 'counterfeit/dow_jones/app'
require 'counterfeit/etherchain/app'
require 'counterfeit/info/app'
require 'counterfeit/ledger/app'
require 'counterfeit/nexmo/app'
require 'counterfeit/ripple/app'
require 'counterfeit/slack/app'

run Rack::URLMap.new(
  '/bitrex'     => Counterfeit::Bittrex::App.new,
  '/blockchain' => Counterfeit::Blockchain::App.new,
  '/dow_jones'  => Counterfeit::DowJones::App.new,
  '/ledger'     => Counterfeit::Ledger::App.new,
  '/etherchain' => Counterfeit::Etherchain::App.new,
  '/'           => Counterfeit::Info::App.new,
  '/nexmo'      => Counterfeit::Nexmo::App.new,
  '/ripple'     => Counterfeit::Ripple::App.new,
  '/slack'      => Counterfeit::Slack::App.new
)
