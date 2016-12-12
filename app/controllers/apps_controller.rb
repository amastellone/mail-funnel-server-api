class AppsController < ApplicationController
	before_action :set_app, only: [:show, :update, :destroy]

	# GET /apps
	def index
		@apps = App.all
		puts json: @apps
		render json: @apps
	end

	# GET /apps/1
	def show
		puts json: @apps
		render json: @app
	end

	# POST /apps
	def create
		@app = App.new(app_params)

		if @app.save
			render :show, status: :created, location: @app
		else
			render json: @app.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /apps/1
	def update
		if @app.update(app_params)
			render :show, status: :ok, location: @app
		else
			render json: @app.errors, status: :unprocessable_entity
		end
	end

	# DELETE /apps/1
	def destroy
		@app.destroy
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_app
		@app = App.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def app_params
		params.require(:app).permit(:name, :api_key, :api_secret)
	end
end
