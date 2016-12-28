source 'https://rubygems.org'

# SERVER

# Job Worker
gem 'postmark-rails'

# gem 'delayed_job_active_record'
# gem 'delayed_job_recurring'
# gem 'whenever', :require => false

gem 'redis-rails'

gem 'resque'
gem 'resque-scheduler'

gem 'foreman'

# gem 'rake', '< 11.1'

# gem 'activerecord-session_store'
# gem 'request_store_registry', :git => 'git://github.com/mikeantonelli/request_store_registry.git'
# /vaskaloidis/request_store_registry

# Security
gem 'rack-cors'
gem 'jwt'
gem 'rack-jwt'
# gem 'knock'

# API-Docs
# gem 'slate-installer'
# gem 'apipie-rails'

gem 'http'

# Seeding Data Generator
gem 'faker'

# REST ORM
# gem 'her'
gem 'bcrypt'

# GRAPE - API-Server
gem 'hashie-forbidden_attributes'
gem 'grape'


gem 'schema_auto_foreign_keys'
gem 'yaml_db'
gem 'dotenv-rails'

# Shopify
gem 'omniauth'
gem 'shopify_api'
# gem 'shopify_app'
gem 'activeresource', :git => 'git://github.com/rails/activeresource.git'
gem 'active_model_serializers', '~> 0.10.0.rc2'

# RAILS
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'

# DATABASE
# gem 'sqlite3'
gem 'pg'

# WEB SERVER
gem 'puma', '~> 3.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use jquery as the JavaScript library
# gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test do
	gem 'simplecov', :require => false
	# gem 'capybara', '~> 2.3.0'
end

group :development, :test do
	# Call 'byebug' anywhere in the code to stop execution and get a debugger console
	gem 'byebug', platform: :mri

	#RSpec
	%w[rspec rspec-core rspec-expectations rspec-rails rspec-mocks rspec-support].each do |lib|
		gem lib, :git => "git://github.com/rspec/#{lib}.git", :branch => 'master'
	end
	# gem 'rspec-rails'

	gem 'factory_girl_rails'

	gem 'spring-commands-rspec'
end

group :development do
	# Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
	# gem 'web-console'
	gem 'listen', '~> 3.0.5'
	# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
	gem 'spring'
	gem 'spring-watcher-listen', '~> 2.0.0'
	gem 'table_print'
	gem 'pry-rails'

	gem 'table_print'
	gem 'pry-rails'
	gem 'meta_request'
	# gem 'quiet_assets'
end

group :production do
	gem 'honeybadger', '~> 2.0'
	gem 'scout_apm'
	gem 'rollbar'
end