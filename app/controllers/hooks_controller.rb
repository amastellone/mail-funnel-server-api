class HooksController < ApplicationController
	before_action :set_hook, only: [:show, :edit, :update, :destroy]

	# GET /hooks
	def index

		if params.has_key?(:name)
			result = Hook.where(name: params[:name])

			if result.size > 1
				return 'Hook does not exist'
			else
				@hooks = result
			end

		elsif params.has_key?(:identifier)
			@hooks = Hook.where(identifier: params[:identifier])

		else
			@hooks = Hook.all

		end

		logger.debug @hooks.as_json
		render json: @hooks

	end

	# GET /hooks/1
	def show
		@hooks = Hook.find(params[:id])
		logger.debug @hooks.as_json
		render json: @hooks
	end

	# GET /hooks/new
	def new
		@hook = Hook.new
	end

	# GET /hooks/1/edit
	def edit
	end


	# POST /hooks
	def create
		@hook = Hook.new(hook_params)

		respond_to do |format|
			render :show, status: :created, location: @hook
			render json: @hook.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /hooks/1
	def update
		if @hook.update(hook_params)
			render :show, status: :ok, location: @hook
		else
			render json: @hook.errors, status: :unprocessable_entity
		end
	end

	# DELETE /hooks/1
	def destroy
		@hook.destroy
		head :no_content
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_hook
		@hook = Hook.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def hook_params
		params.require(:hook).permit(:name, :identifier)
	end
end
