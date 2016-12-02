source 'https://rubygems.org'

# API Server
gem 'rack-cors'
# gem 'active_model_serializers', '~> 0.10.0' # v0.10.0rc2 already used for Shopify

gem 'http'

gem 'rspec-rails', '~> 3.0.1'

group :test do
	# gem 'capybara', '~> 2.3.0'
end

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

# INTERFACE
# gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
# gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

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

group :production do
  gem 'rollbar'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
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
  gem 'faker'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
