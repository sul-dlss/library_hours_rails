server 'sul-library-hours-dev.stanford.edu', user: 'library_hours', roles: %w(web db app)

Capistrano::OneTimeKey.generate_one_time_key!
set :rails_env, 'production'

set :bundle_without, %w{test}.join(' ')
