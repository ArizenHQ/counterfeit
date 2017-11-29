# config.ru

$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'counterfeit/application'

Counterfeit::Application.run!