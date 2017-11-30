module Counterfeit
  class Railtie < Rails::Railtie
  end
end

require 'counterfeit/railtie' if defined?(Rails)