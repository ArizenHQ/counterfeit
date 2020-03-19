require 'counterfeit/base_app'
require 'sinatra'
require 'haml'

module Counterfeit
  module Info
    class App < Counterfeit::BaseApp

      # Need to set this manually b/c it is inherited from counterfeit::BaseApp which is located in a base directory
      set :root, Proc.new { File.expand_path(File.dirname(__FILE__), 'lib/counterfeit/info') }

      get '/' do
        @var = 'yup'
        haml :index
      end

    end
  end
end
