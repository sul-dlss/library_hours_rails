[![Build Status](https://travis-ci.org/sul-dlss/library_hours_rails.svg?branch=master)](https://travis-ci.org/sul-dlss/library_hours_rails)

# Library Hours

This application allows stakeholders to create and maintain library and location hours for the Stanford University Libraries.

Libraries may have many locations within the building, and each may keep separate hours.

Library hours can be created in bulk by setting normal business hours for each quarter, intersession, or other term and add exceptions to e.g. holidays. Library hours can also be imported from a batch upload spreadsheet.

This application also provides API access to those hours for downstream consumers, including:

- legacy JSON API, with routes like: `api/v1/library/:library_id/location/:id/hours/for/:when`
- JSON-API style API, with routes like:
`library/:library_id/location/:id/hours.json`


## Requirements

* Ruby 2

## Installation

```
$ git clone https://github.com/sul-dlss/library_hours_rails.git
$ cd library_hours_rails
$ bundle install
$ rake db:migrate
$ rails server
```

## Configuration

This project uses `rails_config` to manage environment-specific configuration. Default configuration is available in `config/settings.yml` and includes:

- `super_admin_groups`, groups who are able to modify library and location data
- `site_admin_groups`, groups who are able to modify library hours data

## Loading initial hours

You can import libraries and locations from the libraries.stanford.edu website and initial Stanford quarter, intersession and holiday data using the `db:seed` rake task:

```
$ rake db:seed # load libraries and locations from libraries.stanford.edu
```

Initial library hours can be seeded using a CSV export from the library hours website. After importing the CSV spreadsheet, you also need to mark relevant locations as "keeping hours", e.g.:

```ruby
Location.select { |x| x.calendars.any? }.each { |x| x.update(keeps_hours: true) }
```

## Logging in locally

To run the app locally while logged in as an authorized user for the backend, run the following:
```
REMOTE_USER=username@stanford.edu eduPersonEntitlement=group bundle exec rails s
```

## Running the tests

```
$ rake
```
