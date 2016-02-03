# ActivityPermissionEngineRedis

Redis adapter for the activity permission engine gem. ( https://github.com/synbioz/activity_permission_engine ).


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activity_permission_engine_redis'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activity_permission_engine_redis

## Usage

You need redis Gem and a running Redis database. ( See Redis gem documentation )

```ruby
require 'redis'

ActivityPermissionEngine.configure do |config|
    config.activity_permissions_registry = ActivityPermissionEngineRedis::ActivityPermissionsRegistry.new(Redis.new)
end
```

Do not forget to set up redis for persistence.

## Contributing

1. Fork it ( https://github.com/synbioz/activity_permission_engine_redis/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
