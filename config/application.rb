require_relative 'boot'

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

require 'rails/all'

# if defined?(Bundler)
#   # If you precompile assets before deploying to production, use this line
#   Bundler.require(*Rails.groups(assets: %w(development test)))
#   # If you want your assets lazily compiled in production, use this line
#   # Bundler.require(:default, :assets, Rails.env)
# end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module MailFunnelServer
	class Application < Rails::Application
		config.api_only                       = true

		# JSON API Format
		ActiveModelSerializers.config.adapter = ActiveModelSerializers::Adapter::JsonApi
		# ActiveModelSerializers.config.adapter = :json_api
		# ActiveModelSerializers.config.adapter = :json

		# Add Paths to Autoload
		# Lib and Middleware
		config.autoload_paths << "#{Rails.root}/lib"
		config.autoload_paths << "#{Rails.root}/app/middleware"

		# GRAPE API
		config.paths.add 'app/api', glob: '**/*.rb'
		config.autoload_paths                  += Dir["#{Rails.root}/app/api/*"]

		# Resque
		config.active_job.queue_adapter        = :resque
		config.active_job.queue_name_prefix = Rails.env
		config.active_job.queue_name_delimiter = '.'


		# Postmark
		config.action_mailer.delivery_method   = :postmark
		config.action_mailer.postmark_settings = { :api_token => "e0ab21a2-3d3b-432b-8a77-132f25b58aa3" }
		#TODO: Move the Postmark Mailer Config API_Token to .env

		config.generators do |g|
			g.orm :active_record

			g.factory_girl true
			g.test_framework :rspec
			# g.test_framework :test_unit, fixture: true
			# g.test_framework :test_unit, fixture: false

			g.template_engine :erb
			g.stylesheets false
			g.javascripts false
		end

		# Headers
		# config.action_dispatch.default_headers['P3P'] = 'CP="Not used"'
		# config.action_dispatch.default_headers.delete('X-Frame-Options')

		# TODO: Move some of this stuff out to /config/initializers
		# Settings in config/environments/* take precedence over those specified here.
		# Application configuration should go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded.

		# Middleware

		# JSON Web Tokens (TODO: Add JWT to Headers, in middleware)
		# Rails.application.config.middleware.use, Rack::JWT::Auth, my_args

		#Cors
		config.middleware.insert_before 0, Rack::Cors do
			allow do
				origins '*'
				resource '*', :headers => :any, :methods => [:any]
			end
		end
	end
end
