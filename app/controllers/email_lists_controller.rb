class EmailListsController < ApplicationController
	before_action :set_email_list, only: [:show, :update, :destroy]

	# GET /email_lists
	# GET /email_lists.json
	def index
		@email_lists = EmailList.all
		render json: @email_lists
	end

	# GET /email_lists/1
	# GET /email_lists/1.json
	def show
		render json: @email_list
	end

	# POST /email_lists
	def create
		@email_list = EmailList.new(email_list_params)

		if @email_list.save
			render :show, status: :created, location: @email_list
		else
			render json: @email_list.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /email_lists/1
	def update
		if @email_list.update(email_list_params)
			render :show, status: :ok, location: @email_list
		else
			render json: @email_list.errors, status: :unprocessable_entity
		end
	end

	# DELETE /email_lists/1
	def destroy
		@email_list.destroy
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_email_list
		@email_list = EmailList.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def email_list_params
		params.require(:email_list).permit(:app_id, :name, :description)
	end
end
