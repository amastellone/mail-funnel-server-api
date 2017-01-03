# STOCK
require_relative 'config/environment'

run Rails.application


# RESQUE-EXAMPLE
# require ::File.expand_path('./config/environment',  __FILE__)
#
# run Rack::URLMap.new \
#   "/"       => ResqueScheduler::Application,
#   "/resque" => Resque::Server.new


# RESQUE-DOCS
# #!/usr/bin/env ruby
# require 'logger'
#
# $LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/lib')
# require 'resque/server'
#
# # Set the RESQUECONFIG env variable if you've a `resque.rb` or similar
# # config file you want loaded on boot.
# if ENV['RESQUECONFIG'] && ::File.exists?(::File.expand_path(ENV['RESQUECONFIG']))
# 	load ::File.expand_path(ENV['RESQUECONFIG'])
# end
#
# # use Rack::ShowExceptions
# run Resque::Server.new