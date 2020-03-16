# Counterfeit

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/counterfeit`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'counterfeit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install counterfeit

## Run Servers locally

```
docker-compose up
docker-compose exec dev bundle
docker-compose exec dev bin/server
```

Each counterfeit app directory will be mounted at a path of the app name. So `Counterfeit::Nexmo::App` is mounted on `/nexmo`. See `config.ru` for more details. You can visit each endpoint at `localhost:4567/app_dir/some/url/`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/surzycki/counterfeit.

