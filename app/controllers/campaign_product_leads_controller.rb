class CampaignProductLeadsController < ApplicationController
  before_action :set_campaign_product_lead, only: [:show, :update, :destroy]

  # GET /campaign_product_leads
  def index
    @campaign_product_leads = CampaignProductLead.all

    render json: @campaign_product_leads
  end

  # GET /campaign_product_leads/1
  def show
    render json: @campaign_product_lead
  end

  # POST /campaign_product_leads
  def create
    @campaign_product_lead = CampaignProductLead.new(campaign_product_lead_params)

    if @campaign_product_lead.save
      render json: @campaign_product_lead, status: :created, location: @campaign_product_lead
    else
      render json: @campaign_product_lead.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campaign_product_leads/1
  def update
    if @campaign_product_lead.update(campaign_product_lead_params)
      render json: @campaign_product_lead
    else
      render json: @campaign_product_lead.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campaign_product_leads/1
  def destroy
    @campaign_product_lead.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign_product_lead
      @campaign_product_lead = CampaignProductLead.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def campaign_product_lead_params
      params.require(:campaign_product_lead).permit(:app_id, :product_identifier, :campaign_id, :job_id, :sold, :sale_ammount, :EmailList_id, :email_id, :BuyDate, :ClickDate)
    end
end
