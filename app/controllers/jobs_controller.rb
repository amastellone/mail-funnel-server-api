class JobsController < ApplicationController
	before_action :set_job, only: [:show, :update, :destroy]
	# before_action :set_app,  only: [:index]
	# TODO: Possibly set before_action set app_id on Jobs.index

	# GET /jobs?app_id=:app_id&hook_identifier=:hook_identifier
	def index
		logger.info "Using Job.index Controller"

		if params.has_key?(:app_id)
			if params.has_key?(:hook_identifier)
				logger.info "Using Job.index Controller, app_id / hook_identifier " + params[:app_id] + " / " + params[:hook_identifier]
				@jobs = Job.where(app_id: params[:app_id], hook_identifier: params[:hook_identifier])
			else
				if params.has_key?(:client_campaign)
					logger.info "Using Job.index Controller, app_id: " + params[:app_id] + " / client_campaign: " + params[:client_campaign]
					@jobs = Job.where(app_id: params[:app_id], client_campaign: params[:client_campaign])
				else
					logger.info "Using Job.index Controller, app_id: " + params[:app_id]
					@jobs = Job.where(app_id: params[:app_id])
				end
			end
		else
			@jobs = Job.all
			# render :json => { :errors => "Must pass-in an app-id" }
		end
		logger.info "Jobs Query Return JSON:"
		logger.info @jobs.to_json
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

	def create
		@job = Job.new(job_params)

		development = true

		if development
			today = Date.today

			wait_once = Time.new(today.year, today.month, today.day, today.hour, today.minute + 1, 0)

			wait_twice = Time.new(today.year, today.month, today.day, today.minute + 2, 0)

			wait_thrice = Time.new(today.year, today.month, today.day, today.minute + 3, 0)
		else
			tomorrow  = Date.tomorrow
			wait_once = Time.new(tomorrow.year, tomorrow.month, tomorrow.day, @job.execute_time, 0)

			two_days   = tomorrow.tomorrow
			wait_twice = Time.new(two_days.year, two_days.month, two_days.day, @job.execute_time, 0)

			three_days  = two_days.tomorrow
			wait_thrice = Time.new(three_days.year, three_days.month, three_days.day, @job.execute_time, 0)
		end

		if @job.save

			# SendEmail Signature: # app_id, email_list_id, email_subject, email_content, execute_time
			case @job.execute_frequency

				when 'immediate'
					# SendEmailJob.perform_now(@job.app_id, @job.email_list_id, @job.content, @job.subject)
				when 'execute_once'
				Resque.enqueue_at_with_queue(
					 'default',
					 wait_once,
					 SendEmailJob,
					 app_id: @job.app_id,
				   email_list_id: @job.email_list_id,
				   email_subject: @job.email_subject,
				   email_content: @job.email_content
				)
				when 'execute_twice'
					Resque.enqueue_at_with_queue(
						 'default',
						 wait_once,
						 SendEmailJob,
						 app_id: @job.app_id,
						 email_list_id: @job.email_list_id,
						 email_subject: @job.email_subject,
						 email_content: @job.email_content
					)
					Resque.enqueue_at_with_queue(
						 'default',
						 wait_twice,
						 SendEmailJob,
						 app_id: @job.app_id,
						 email_list_id: @job.email_list_id,
						 email_subject: @job.email_subject,
						 email_content: @job.email_content
					)
				when 'execute_thrice'
					Resque.enqueue_at_with_queue(
						 'default',
						 wait_once,
						 SendEmailJob,
						 app_id: @job.app_id,
						 email_list_id: @job.email_list_id,
						 email_subject: @job.email_subject,
						 email_content: @job.email_content
					)
					Resque.enqueue_at_with_queue(
						 'default',
						 wait_twice,
						 SendEmailJob,
						 app_id: @job.app_id,
						 email_list_id: @job.email_list_id,
						 email_subject: @job.email_subject,
						 email_content: @job.email_content
					)
					Resque.enqueue_at_with_queue(
						 'default',
						 wait_thrice,
						 SendEmailJob,
						 app_id: @job.app_id,
						 email_list_id: @job.email_list_id,
						 email_subject: @job.email_subject,
						 email_content: @job.email_content
					)
			end

			render json: @job, status: :created, location: @job
		else
			render json: @job.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /jobs/1
	def update
		if @job.update(job_params)
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