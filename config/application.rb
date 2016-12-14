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
    config.api_only = true

    ActiveModelSerializers.config.adapter = ActiveModelSerializers::Adapter::JsonApi
    # ActiveModelSerializers.config.adapter = :json_api
    # ActiveModelSerializers.config.adapter = :json

    # Rails.application.config.middleware.use, Rack::JWT::Auth, my_args

    # Lib
    config.autoload_paths << "#{Rails.root}/lib"
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << "#{Rails.root}/app/middleware"
    config.paths.add 'app/api', glob: 'lib/*.rb'


    # config.action_dispatch.default_headers['P3P'] = 'CP="Not used"'
    # config.action_dispatch.default_headers.delete('X-Frame-Options')

    # GRAPE
    config.paths.add 'app/api', glob: '**/*.rb'
    config.autoload_paths += Dir["#{Rails.root}/app/api/*"]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.middleware.insert_before 0, Rack::Cors do
	    allow do
		    origins '*'
		    resource '*', :headers => :any, :methods => [:any]
	    end
    end
  end
end
