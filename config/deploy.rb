require 'bundler/capistrano'

set :application, "SecFly"
set :repository, "git@github.com:phuong3030/SecFly.git"

set :scm, :git

set(:env, 'production') unless exists?(:env)
set(:branch, 'master') unless exists?(:branch)

set :use_sudo, false
set :domain, '128.199.156.230'
set :user, "root"
set :deploy_to, "/home/deploy/#{application}"
set :deploy_via, :remote_cache
set :deploy_env, 'production'

role :web, domain 
role :app, domain
role :db, domain, :primary => true

set :git_shallow_clone, 1
set :scm_verbose, true

namespace :deploy do
	[:start, :stop, :restart].each do |t|
		desc "#{t} server"
		task t, :roles => :app do
			sudo "/etc/init.d/nginx #{t}"
			sudo "/etc/init.d/thin #{t}"
		end
	end

	task :precompile do
		run "cd #{release_path}; source $HOME/.bash_profile && bundle exec rake assets:precompile RAILS_ENV=production"
	end

	task :migration do
		run "cd #{release_path}; source $HOME/.bash_profile && bundle exec rake db:migrate RAILS_ENV=production"
	end

end

after 'deploy:update', 'deploy:resymlink'
