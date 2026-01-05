# Datewari

An ActiveRecord extension to build date oriented pagination links such as monthly pages and weekly pages.

## Dependencies

* ruby 3.0+
* rails 7.0+ (activerecord, activesupport, actionview)

Following ActiveRecord adapters are supported:

* mysql
* postgresql

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
users = User.date_paginate(:created_at, :desc, date: '2018-01-01', scope: :yearly)

# monthly pagination
users = User.date_paginate(:created_at, :desc, date: '2018-01-01', scope: :monthly)

# weekly pagination
users = User.date_paginate(:created_at, :desc, date: '2018-01-01', scope: :weekly)

# daily pagination
users = User.date_paginate(:created_at, :desc, date: '2018-01-01', scope: :daily)
```

### Access paginator variables

You can get paginator variables as follows:

```ruby
# dates of pages
users.paginator.pages

# count of total entries
users.paginator.total_entries
```

### Render pagination links

Render pagination links:

```ruby
date_paginate users

# with options
date_paginate users, previous_label: 'Prev', next_label: 'Next'
```

Available options:

* `previous_label`: label for previous link.
* `next_label`: label for next link.
* `page_gap`: label for abbrebiated pages.
* `link_separator`: label between pages.
* `yearly_format`: date format for yearly pagination.
* `monthly_format`: date format for monthly pagination.
* `weekly_format`: date format for weekly pagination.
* `daily_format`: date format for daily pagination.
* `inner_window`: window size around current page link. default: `4`.
* `outer_window`: window size around first page and last page link. default: `1`.
* `page_links`: render page links or not. default: `true`.
* `param_name`: query parameter name. default: `date`.
* `params`: optional parameters for page links.
* `renderer`: custom link render class.

### Render page info

Render page info:

```ruby
date_page_entries_info users
```

### I18n

I18n default values are as follows:

```yaml
en:
  date_paginate:
    previous_label: "&#8592; Previous"
    next_label: "Next &#8594;"
    page_gap: "&hellip;"
    link_separator: "|"
    yearly_format: "%Y"
    monthly_format: "%Y-%m"
    weekly_format: "%Y-%m-%d"
    daily_format: "%Y-%m-%d"
    page_entries_info:
      single_page:
        zero: "No items found"
        other: "Displaying <b>%{total}</b> items"
      multi_page: "Displaying <b>%{current}</b> of <b>%{total}</b> in total"
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/datewari.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
