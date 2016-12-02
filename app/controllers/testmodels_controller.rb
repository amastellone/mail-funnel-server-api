class TestmodelsController < ApplicationController
  before_action :set_testmodel, only: [:show, :update, :destroy]

  # GET /testmodels
  def index
    @testmodels = Testmodel.all

    render json: @testmodels
  end

  # GET /testmodels/1
  def show
    render json: @testmodel
  end

  # POST /testmodels
  def create
    @testmodel = Testmodel.new(testmodel_params)

    if @testmodel.save
      render json: @testmodel, status: :created, location: @testmodel
    else
      render json: @testmodel.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /testmodels/1
  def update
    if @testmodel.update(testmodel_params)
      render json: @testmodel
    else
      render json: @testmodel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /testmodels/1
  def destroy
    @testmodel.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testmodel
      @testmodel = Testmodel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def testmodel_params
      params.require(:testmodel).permit(:name, :age)
    end
end
