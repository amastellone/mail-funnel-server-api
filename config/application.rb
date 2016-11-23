require_relative 'boot'

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(assets: %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module MailFunnelServer
  class Application < Rails::Application
    # config.action_dispatch.default_headers['P3P'] = 'CP="Not used"'
    # config.action_dispatch.default_headers.delete('X-Frame-Options')

    config.paths.add 'app/api', glob: '**/*.rb'
    config.autoload_paths += Dir["#{Rails.root}/app/api/*"]

    # Grape
    #config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    #config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    #config.api_only = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
