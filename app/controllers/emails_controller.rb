class EmailsController < ApplicationController
	before_action :set_email, only: [:show, :update, :destroy]
	# before_action :set_list, only: [:index] # TODO: Enable the before_action for emails_controller

	# GET /emails
	def index
		if params.has_key?(:app_id)
			if params.has_key?(:email_list_id)
				@emails = Email.where(app_id: params[:app_id], email_list_id: params[:email_list_id])
			else
				puts "the right spot - just app_id"
				@emails = Email.where(app_id: params[:app_id])
			end
		else
			if params.has_key?(:email_list_id)
				@emails = Email.where(email_list_id: params[:email_list_id])
			else
			# 	TODO: Throw an error
			end
		end

		logger.debug json: @emails
		render json: @emails
	end

	# GET /emails/1
	def show
		render json: @email
	end

	# POST /emails
	def create
		@email = Email.new(email_params)

		if @email.save
			render :show, status: :created, location: @email
		else
			render json: @email.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /emails/1
	def update
		if @email.update(email_params)
			render :show, status: :ok, location: @email
		else
			render json: @email.errors, status: :unprocessable_entity
		end
	end

	# DELETE /emails/1
	def destroy
		@email.destroy
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_email
		@email = Email.find(params[:id])
	end

	# def set_list
	# 	@list = EmailList.find(params[:email_list_id])
	# end

	# Never trust parameters from the scary internet, only allow the white list through.
	def email_params
		# TODO: Implement a require(:email). requirement

		params.require(:email).permit(:email_address, :name, :email_list_id, :app_id)
	end
end
