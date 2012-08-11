# Runlimited

Runlimited is a simple implementation of a rate limiter allowing
one to make sure their code isn't running any faster than you is
absolutely necessary.

This implementation is very simplistic. For a more robust rate limiting
solution I recommend checking out one of the following solutions:

http://rubygems.org/gems/ratelimit
http://rubygems.org/gems/rack-ratelimiter


## Installation

Add this line to your application's Gemfile:

    gem 'runlimited'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install runlimited

## Usage

    limiter = Runlimited::Redis.new( :interval => 10 ) # Allow a minimum of 5 seconds between code

    limiter.limit do
      Big::Api.call
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
