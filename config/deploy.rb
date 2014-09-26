require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "nacenopto"
set :repository, "git@github.com:phuong3030/SecFly.git"

set :scm, :git
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :default_shell, '/bin/bash -l'
set :rvm_ruby_string, 'ruby-2.1.2'

set(:env, 'production') unless exists?(:env)
set(:branch, 'master') unless exists?(:branch)

set :use_sudo, false
set :domain, '128.199.156.230'
set :user, "deploy"
set :deploy_to, "/home/deploy/#{application}"
set :deploy_env, 'production'

role :web, domain 
role :app, domain
role :db, domain, :primary => true

set :git_shallow_clone, 1
set :scm_verbose, true

namespace :deploy do
	task :start_server do 
		run <<-SHELL
		  cd #{deploy_to}/current/ && thin start -C #{deploy_to}/current/thin.yml
		SHELL
	end

	task :stop_server do
		run <<-SHELL
		  cd #{deploy_to}/current/ && thin stop -C '#{deploy_to}/current/thin.yml
		SHELL
	end
	
	task :bundle_gems do 
		run "cd #{deploy_to}/current && bundle install"
	end
end

before "deploy", "deploy:stop_server"
after "deploy", "deploy:bundle_gems", "deploy:migrate", "deploy:start_server"
