class JobsController < ApplicationController
	before_action :set_job, only: [:show, :update, :destroy]
	# before_action :set_app,  only: [:index]
	# TODO: Possibly set before_action set app_id on Jobs.index

	# GET /jobs?app_id=:app_id&hook_identifier=:hook_identifier
	def index
		logger.info "Using Job.index Controller"

		if params.has_key?(:app_id)
			if params.has_key?(:campaign_id)
				@jobs = Job.where(app_id: params[:app_id], campaign_id: params[:campaign_id])
			else
				@jobs = Job.where(app_id: params[:app_id])
			end
		elsif params.has_key?(:campaign_id)
			@jobs = Job.where(campaign_id: params[:campaign_id])
		else
			logger.error "Jobs-Controller GET Query - no app_id was passed with the query"
			return 'Must pass-in an app-id'
		end

		logger.debug @jobs.as_json
		render json: @jobs
	end

	# GET /jobs/1
	def show
		render json: @job
	end


	# POST /jobs
	def create_2
		@job = Job.new(job_params)

		if @job.save
			render json: @job, status: :created, location: @job
		else
			render json: @job.errors, status: :unprocessable_entity
		end
	end

	# resque-scheduler info
	# https://github.com/leshill/resque_spec/blob/master/spec/resque_spec/scheduler_spec.rb
	def create
		@job = Job.new(job_params)

		if @job.save

			# SendEmail Signature: # app_id, email_list_id, subject, content, execute_time

			thisjob = SendEmailJob
				      .set(
					       wait: @job.execute_time.minutes) # TODO: Change to hours in PROD
				      .perform_later(
								 app_id:        @job.app_id,
								 email_list_id: @job.email_list_id,
								 subject:       @job.subject,
								 content:       @job.content
							)
			@job.queue_identifier = thisjob.provider_job_id
			@job.save

			# provider_job_id

			render json: @job, status: :created, location: @job
		else
			render json: @job.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /jobs/1
	def update

		if @job.executed && job_params.executed == false

			success = @job.update(job_params)

			thisjob = SendEmailJob
				      .set(
					       wait: @job.execute_time.minutes) # TODO: Change to hours in PROD
				      .perform_later(
								 app_id:        @job.app_id,
								 email_list_id: @job.email_list_id,
								 subject:       @job.subject,
								 content:       @job.content
							)
			@job.queue_identifier = thisjob.provider_job_id
			@job.save

			if success 
				render json: @job
			else
				render json: @job.errors, status: :unprocessable_entity

			end

		elsif @job.update(job_params)
			render json: @job
		else
			render json: @job.errors, status: :unprocessable_entity
		end
	end

	# DELETE /jobs/1
	def destroy
		# Resque.remove_delayed(SendFollowUpEmail, :user_id => current_user.id)


		@job.destroy

	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_job
		@job = Job.find(params[:id])
	end

	def set_app
		@jobs = Job.where(app_id: params[:app_id])
	end

	def job_app_id_param
		params.require(:job).require(:app_id)
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def job_params
		# TODO: SERVER-CONTROLLER: Updates the Job required-param, to only permit specific params
		params.require(:job).permit!

		# .permit(:executed, :execute_time, :execute_frequency,
		#                             :subject, :content, :name,
		#                             :campaign_identifier, :client_campaign,
		#                             :email_list_id, :app_id,
		#                             :hook_identifier, :content,
		#                             :campaign_identifier)
	end

end