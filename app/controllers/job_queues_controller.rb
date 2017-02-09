class JobQueuesController < ApplicationController

	def index

		if params.has_key?(:queue_identifier)
			# Code to sidekiq
			if sidekiq.job_id == true
				#return job status
				#If run
			
			elsif sidekiq.job_id == false
				#job was already executed
			else
				#this job doesnt exist
			end
		else
			logger.error "Jobs-Queue-Controller GET Queued Jobs - no queue_identifier was provided"
			return 'Must pass-in an app-id'
		end

		render json: @jobs

	end


end
