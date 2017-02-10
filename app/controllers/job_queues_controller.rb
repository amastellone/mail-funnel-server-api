class JobQueuesController < ApplicationController

	def index

		if params.has_key?(:queue_identifier)
			# Code to sidekiq
			queued_job = Sidekiq::Status::get_all params[:queue_identifier]
			if queued_job
				return queued_job
			else
				logger.error "This Job does not exists in Sidekiq"
			end
		else
			logger.error "Jobs-Queue-Controller GET Queued Jobs - no queue_identifier was provided"
			return 'Must pass-in an app-id'
		end

	end


end
