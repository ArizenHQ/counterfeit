# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "counterfeit/version"

Gem::Specification.new do |spec|
  spec.name          = "counterfeit"
  spec.version       = Counterfeit::VERSION
  spec.authors       = ["Coinhouse"]
  spec.email         = ["stefan.surzycki@gmail.com"]

  spec.summary       = %q{Faking cryptocurrency exchanges for fun and profit}
  spec.description   = %q{Faking cryptocurrency exchanges for fun and profit}
  spec.homepage      = "https://www.coinhouse.fr"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'bin'
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7.8'

  spec.add_dependency 'sinatra'          ,'~> 4.0'
  spec.add_dependency 'sinatra-contrib'  ,'~> 4.0'
  spec.add_dependency 'haml'
  spec.add_dependency 'webmock'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'byebug'
end
