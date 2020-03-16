require 'sinatra/base'

module Counterfeit
  class BaseApp < Sinatra::Base

    def self.site_logger
      @@logger ||= Logger.new('/var/www/log/counterfeit')
    end

    before do
      BaseApp.site_logger.info("COUNTERFEIT REQUEST FIRED: '#{request.host}#{request.fullpath}")
    end
  end
end
