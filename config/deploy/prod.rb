server 'library-hours-prod.stanford.edu', user: 'library_hours', roles: %w(web db app)

Capistrano::OneTimeKey.generate_one_time_key!
set :rails_env, 'production'
