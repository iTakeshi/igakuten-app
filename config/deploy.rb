puts "\n\e[0;31m Are you sure? \e[0m\n"
proceed = STDIN.gets[0..0] rescue nil
exit unless proceed == 'y' || proceed == 'Y'

# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'igakuten-app'
set :repo_url, 'https://github.com/iTakeshi/igakuten-app'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/igakuten-app'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{ config/initializers/secret_token.rb }

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :rails_env, 'production'

server 'app.hokudai-igakuten.org', roles: %w{ app web db }, user: 'igakuten', port: 10022, ssh_options: {
  keys: [File.expand_path('~/.ssh/igakuten_rsa')]
}

namespace :deploy do
  desc 'start server'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute '/var/www/igakuten-app/current/init.sh start'
    end
  end

  desc 'stop server'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute '/var/www/igakuten-app/current/init.sh stop'
    end
  end

  desc 'restart server'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute '/var/www/igakuten-app/current/init.sh restart'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
