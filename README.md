# Datewari

An ActiveRecord extension to build date oriented pagination links such as monthly pages and weekly pages.

## Dependencies

* ruby 2.3+
* activerecord 5.0+
* actionview 5.0+

Currently MySQL and PostgreSQL are supported.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'datewari'
```

Then execute:

    $ bundle

## Usage

Paginate collection by `created_at` column:

```ruby
# yearly pagination
users = User.date_paginate(:created_at, :desc, scope: :yearly)

# monthly pagination
users = User.date_paginate(:created_at, :desc, scope: :monthly)

# weekly pagination
users = User.date_paginate(:created_at, :desc, scope: :weekly)

# daily pagination
users = User.date_paginate(:created_at, :desc, scope: :daily)
```

### Render pagination links

Render pagination links using paginated collection:

```erb
<%= date_paginate users %>
```

### Render page info

Render page info using paginated collection:

```erb
<%= date_page_entries_info users %>
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/datewari.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
