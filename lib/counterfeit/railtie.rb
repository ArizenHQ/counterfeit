module Counterfeit
  class Railtie < Rails::Railtie
    initializer 'counterfeit_railtie.logger' do
      Counterfeit.logger = Rails.logger
    end
  end
end
