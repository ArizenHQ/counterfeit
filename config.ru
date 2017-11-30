#require File.expand_path('my_app', File.dirname(__FILE__))
$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'counterfeit/info/app'

Counterfeit::Info::App.run!