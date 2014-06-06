# LazyAttributes

lazy_attributes is an ActiveRecord plugin. lazy_attributes loads lazily
specified attributes.

## Installation

Add this line to your application's Gemfile:

    gem 'lazy_attributes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lazy_attributes

## Usage

In Active Record model, specify attributes that are needed to be loaded
lazyly with `lazy_attributes`:

```ruby
class User < ActiveRecord::Base
  lazy_attributes :profile
  lazy_attributes :address, :bio
end
```

When model with lazyly-loaded attributes is associated with another
model, you need specify `select` option in association with
'.column_symbols_without_lazy'.

```ruby
class Group < ActiveRecord::Base
  has_many :users, select: User.column_symbols_without_lazy
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/lazy_attributes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
