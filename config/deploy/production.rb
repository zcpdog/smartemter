set :whenever_environment, 'production'
server "23.253.41.149", :web, :db, :app, :primary => true
set :user, "smartmeter"
set :rails_env, "production"
set :application, 'smartmeter'
set :deploy_to,   "/home/smartmeter/var/www/#{application}"
set :db_user,        "root"
set :db_password,    "ituitu"
set :db_encoding,    "utf8"
set :db_adapter,     "mysql2"
set :remote_db_name,  "#{application}_#{rails_env}"
