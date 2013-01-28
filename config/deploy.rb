require 'bundler/capistrano'
set :application, 'm-o.com.ua'
set :repository,  "git@github.com:freiwillen/billboards.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server  "m-o.com.ua", :app, :web, :db, :primary => true                          # Your HTTP server, Apache/etbbbc

set :user, 'freiwillen'
set :use_sudo, false
set :deploy_to, "/home/freiwillen/www/#{application}"
#set :deploy_via, :remote_cache
set :keep_releases, 5
#set :rvm_ruby_string, 'ree-1.8.7-2011.03@mcdim'
set :rvm_ruby_string, 'ree-1.8.7-2011.03@billboards_new'
set :rvm_type, :system
# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
after 'deploy:update_code', 'deploy:symlink_shared'
#after 'deploy:update', 'rvm:use_gemset'

require "rvm/capistrano"  

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "touch #{File.join(current_path,'tmp','restart.txt')}"
 end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    #run "ln -nfs #{shared_path}/config/setup_load_paths.rb #{release_path}/config/setup_load_paths.rb"
    run "cp #{shared_path}/config/.rvmrc #{release_path}/.rvmrc"
    run "ln -nfs #{shared_path}/system #{release_path}/public/system"
    run "mkdir #{release_path}/tmp/offers"
  end

end
namespace :rvm do
  task :use_gemset do
    desc 'Trust rvmrc file'
    run "rvm rvmrc trust #{current_release}"
    #run 'rvm use ree-1.8.7-2011.03@mcdim'
  end
end

