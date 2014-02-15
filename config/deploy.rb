require "rvm/capistrano"
require "bundler/capistrano"
require 'capistrano/ext/multistage'

set :whenever_command, "bundle exec whenever"

set :stages, ["staging", "production"]
set :default_stage, "staging"
default_run_options[:pty] = true
set :repository,  "git@github.com:zcpdog/smartemter.git"
set :deploy_via, :remote_cache
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :use_sudo, false
set :keep_releases, 4
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"
after "deploy:setup", "deploy:create_database_yaml"
before "deploy:assets:precompile", "deploy:config_symlink"
after "deploy:create_symlink", "deploy:migrate"

namespace :deploy do
  desc "Creates database.yml for project/branch"
  task :create_database_yaml do
    sudo "mkdir -p #{shared_path}/config"
    sudo "chown #{user}:#{user} #{shared_path}/config"
    db = {
      "#{rails_env}" => {'adapter' => db_adapter, 'encoding' => db_encoding, 
        'database' => "#{remote_db_name}", 'username' => db_user, 'password' => db_password}
      }
    put db.to_yaml, "#{shared_path}/config/database.yml"
  end
  
  desc "copy database.yml to /current_release/config"
  task :config_symlink do
    run "ln -nsf #{shared_path}/config/database.yml #{current_release}/config"
    #run "ln -nsf #{shared_path}/log/production.log #{current_release}/log/production.log"
  end
  
  task :restart do
    sudo "/etc/init.d/nginx restart"
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
end

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end