set :deploy_host, 'sul-library-hours-dev.stanford.edu'
set :user, 'library_hours'

server fetch(:deploy_host), user: fetch(:user), roles: %w(web db app)

Capistrano::OneTimeKey.generate_one_time_key!
set :rails_env, 'development'
