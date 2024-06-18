# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.2'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 6.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 4.1'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'capybara', '>= 3.26'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'

  gem 'selenium-webdriver'

  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'simplecov', require: false
end

group :deployment do
  gem 'capistrano'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'dlss-capistrano'
end

group :production do
  gem 'mysql2'
end

gem 'cancancan'
gem 'config'
gem 'dotenv'
gem 'faraday'
gem 'friendly_id'
gem 'gretel'
gem 'honeybadger'
gem 'nokogiri', '>= 1.7.1'
gem 'okcomputer'
gem 'global_alerts'
gem 'tophat'
gem 'recaptcha'
gem 'rack-attack'

gem "cssbundling-rails", "~> 1.1"
gem "importmap-rails", "~> 2.0"
gem 'propshaft'
gem "stimulus-rails", "~> 1.2"
gem "turbo-rails", "~> 2.0"
