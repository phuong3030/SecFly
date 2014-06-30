source 'https://rubygems.org'

gem 'rails'

# Use sqlite3 as the database for Active Record
group :development, :test do
	gem 'sqlite3'

	# Use for debug
	gem 'pry'
end

# Use postgreSQL as production database
group :production, :staging do
	gem 'pg'
	gem 'thin'

	# generate sitemap
	gem 'sitemap_generator'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Generate excel file
gem 'acts_as_xlsx', git: 'git://github.com/straydogstudio/acts_as_xlsx.git'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# paginator
gem 'kaminari'

# websockets for rails
gem 'websocket-rails', :git => 'https://github.com/websocket-rails/websocket-rails.git'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# File uploading plugin
gem "paperclip", github: 'thoughtbot/paperclip'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

gem 'capistrano'
gem 'rvm-capistrano'

# Use debugger
# gem 'debugger', group: [:development, :test]
