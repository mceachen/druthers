# Druthers

[![Build Status](https://api.travis-ci.org/mceachen/druthers.png?branch=master)](https://travis-ci.org/mceachen/druthers)
[![Gem Version](https://badge.fury.io/rb/druthers.png)](http://rubygems.org/gems/druthers)
[![Code Climate](https://codeclimate.com/github/mceachen/druthers.png)](https://codeclimate.com/github/mceachen/druthers)

```Druthers``` is the simplest performant solution to storing application-specific settings via
ActiveRecord.

When you use an off-the-shelf Rails application, frequently you'll need to store
configuration information specific to your installation.

If you store that information in a flat file, and you subsequently upgrade the rails application,
you'll need to make sure your settings don't get overwritten. If you're running multiple servers,
you'll need to store those settings in a shared datastore. If you're already using ActiveRecord,
we might as well use ActiveRecord to store this.

Druthers is a simple enhancement to a key/value model that adds caching and the ability to override
behavior for specific settings.

As opposed to ```rails-settings``` and forks, ```method_missing``` isn't used anywhere. *HURRAY!*

## Supported versions

The latest versions of
* Rails 3.2 & 4.0
* Ruby 1.9.3 & 2.0.0
* SQLite, MySQL, and PostgreSQL

Every valid combination is [tested via Travis](https://travis-ci.org/mceachen/druthers).

## Usage

Assuming your configuration is stored via a ```Setting``` model:

```ruby
class Setting < ActiveRecord::Base

  # Add class-level getter/setters for your settings:
  def_druthers :quest, :favourite_colour

  # This is not required, but allows for more than just string values:
  serialize :value

  # This will be used as the value of `Setting.quest` if it is not set.
  def self.default_quest
    "to find the holy grail"
  end

  # This validation will be only run for instances whose key == "favourite_color":
  def validate_favourite_colour
    add_error("we're right out of teal, sorry") if value == "teal"
  end
end
```

You can get values:

```ruby
Setting.quest
=> "to find the holy grail" # <- because we defined default_quest above

Setting.favourite_color
=> nil # <- no default
```

You can set values:

```ruby
Setting.favourite_color = "red"
```

If you want to store more than just strings, use
[serialize](http://apidock.com/rails/ActiveRecord/AttributeMethods/Serialization/ClassMethods/serialize),
which is in the above example, and is not required.

## Installation

Add this line to your application's Gemfile:

```
gem 'druthers'
```

And then execute:

```
$ bundle
```

Add a model:

```
rails g model Setting key:string value:text
```

Edit the resulting migration to add an index. Here's a complete example:

```ruby
class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key
      t.text :value
      t.timestamps
    end
    add_index :settings, [:key], :unique => true, :name => 'key_udx'
  end
end
```

Finally, edit your model, adding ```has_druthers``` and the appropriate defaults and validations.
See the Usage section above for more details.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests and code
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
