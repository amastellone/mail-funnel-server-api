require 'rails_helper'

RSpec.describe "CampaignProductLeads", type: :request do
  describe "GET /campaign_product_leads" do
    it "works! (now write some real specs)" do
      get campaign_product_leads_path
      expect(response).to have_http_status(200)
    end
  end
end
