require 'sinatra/base'
require 'counterfeit'

module Counterfeit
  class BaseApp < Sinatra::Base
    before do
      Counterfeit.logger.info("COUNTERFEIT REQUEST FIRED: '#{request.host}#{request.fullpath}")
    end
  end
end
