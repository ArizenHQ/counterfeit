require 'rubygems'
require 'sinatra'
require 'sinatra'
require 'rabl'

Rabl.register!

module Counterfeit
  class Application < Sinatra::Base
    set :bind, '0.0.0.0'

    get '/ping' do
      @pong = { ping: 'pong' }
      rabl :ping, format: 'json'
    end
  end
end