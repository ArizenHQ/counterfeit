# config.ru

$LOAD_PATH << File.expand_path("../lib", __FILE)
require "counterfeit/application"

run Counterfeit::Application