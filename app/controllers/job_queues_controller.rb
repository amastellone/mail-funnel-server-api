require 'json'

class JobQueuesController < ApplicationController

	def index

		if params.has_key?(:queue_identifier)
			# fetch job status from sidekiq-status
			status = Sidekiq::Status::get_all(params[:queue_identifier])
    		logger.debug "The status of this job is: " + status['status']
    		my_hash = {:status => status['status']}
			render :json => status['status']
		else
			logger.error "Jobs-Queue-Controller GET Queued Jobs - no queue_identifier was provided"
			return 'Must pass-in an queue_identifier'
		end

	end


end
