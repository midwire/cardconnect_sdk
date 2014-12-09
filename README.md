# CardconnectSdk

CardconnectSdk wraps the CardConnect JSON API in a ruby wrapper
See: http://www.cardconnect.com/developer/docs/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cardconnect_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cardconnect_sdk

## Usage

TODO: Write usage instructions here

## Development TODO List

* Get the Refund method to work with a transaction that's settled
* Wrap the returned transactions (txns) from...
> * Settlement Status
> * Deposit
> * Funding
* Implement Authorization#userfields (if necessary)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cardconnect_sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
