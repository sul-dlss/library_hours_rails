set :deploy_host, ENV['CAPISTRANO_DEVELOPMENT_DEPLOY_HOST'] || ask(:deploy_host, '')
set :user, ENV['CAPISTRANO_DEVELOPMENT_USER'] || ask(:user, '')

server fetch(:deploy_host), user: fetch(:user), roles: %w(web db app)

Capistrano::OneTimeKey.generate_one_time_key!
set :rails_env, 'development'
