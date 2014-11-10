# KennyLoggins

A general purpose interface for activity logging
An extendable module for adding custom activity types

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kenny_loggins'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kenny_loggins

## Usage

1. Define a new Activity Processor
  - Define "SUBSCRIBED EVENT" to trigger processing on matching activity events
  - Implement .transform to describe how to transform the generic activity data into something interesting

2. Register the processor with Kenny Loggins

```ruby
# Define a new Activity Processor

class SomeNewLogItem < CassandraRecord::Base
  # Define the Activity we are interested in
  SUBSCRIBED_EVENT = 'cool event'

  class << self
    # Transforms generic activity data into
    # a shape more appropriate for this Item
    def transform(raw_attrs)
      return {} unless attrs.has_key?(:data)

      HashWithIndifferentAccess.new({
        blah: data['some_interesting_data_key'],
        whatever: data['another_interesting_data_key']
      })
    end
  end
end


# Register the new Activity Processor with KennyLoggins
KennyLoggins::Logger.register_log_item_type(SomeNewLogItem)

# when an activity event occurs, 
# KennyLoggins will do the following:
# - find all registered item types subscribed to the event
# - call .transform to obtain parsed item attributes
# - call .create with the item attributes
```

## Contributing

1. Fork it ( https://github.com/zephyr-dev/kenny_loggins/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
