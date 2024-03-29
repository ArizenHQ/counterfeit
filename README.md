# Counterfeit

Simple tool based on [Webmock](https://github.com/bblimke/webmock) and [Sinatra](https://github.com/sinatra/sinatra) to quickly stub API endpoints

## Installation

Add this line to your application's Gemfile:

```ruby
# Latest version (usually)
gem 'counterfeit', git: 'https://github.com/ArizenHQ/counterfeit.git'

# Specific version
gem 'counterfeit', git: 'https://github.com/ArizenHQ/counterfeit.git', tag: 'v0.1.13'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install counterfeit

## Usage

**NOTE:**
Take a look at `lib/example/app.rb` to get an example implementation

1. Load your plugin file(s):

```ruby
require "counterfeit/example/app"
require "counterfeit/third_party_api/app"
```

2. And then initialize them with Counterfeit:
```ruby
Counterfeit.enable!([
    Counterfeit::Example,
    Counterfeit::ThirdPartyRestAPI,
    ...
])
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


