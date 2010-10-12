set :application, "lolcount"

set :deploy_to, "/var/www/#{application}"

set :scm, :git
set :repository, "git@bentoncreation.unfuddle.com:bentoncreation/lolcount.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, 'deploy'
set :ssh_options, { :forward_agent => true }
set :use_sudo, false

task :production do
  role :app, "lolcount.com"
  role :web, "lolcount.com"
  role :db,  "lolcount.com", :primary => true
end

task :staging do
  role :app, "lolcount.local"
  role :web, "lolcount.local"
  role :db,  "lolcount.local", :primary => true
end


namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Start Application -- not needed for Passenger"
  task :start, :roles => :app do
    # nothing -- need to override default cap start task when using Passenger
  end
  
  desc "Create database.yml in shared/config"
  task :setup_production_database_configuration do
    mysql_password = Capistrano::CLI.password_prompt("Production MySQL password: ")
    require 'yaml'
    spec = { "production" => {
      "adapter" => "mysql",
      "encoding" => "utf8",
      "database" => "lolcount_production",
      "username" => "lolcount",
      "password" => mysql_password } }
    run "mkdir -p #{shared_path}/config"
    put(spec.to_yaml, "#{shared_path}/config/database.yml")
  end

  desc "Copy database.yml from shared/config to current release"
  task :copy_production_database_configuration do
    run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Update the crontab file"
  task :update_crontab do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end

end

after "deploy:setup", "deploy:setup_production_database_configuration"
after "deploy:update_code", "deploy:copy_production_database_configuration"
after "deploy:symlink", "deploy:update_crontab"