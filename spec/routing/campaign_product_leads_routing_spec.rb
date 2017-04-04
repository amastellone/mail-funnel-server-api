require "rails_helper"

RSpec.describe CampaignProductLeadsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/campaign_product_leads").to route_to("campaign_product_leads#index")
    end


    it "routes to #show" do
      expect(:get => "/campaign_product_leads/1").to route_to("campaign_product_leads#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/campaign_product_leads").to route_to("campaign_product_leads#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/campaign_product_leads/1").to route_to("campaign_product_leads#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/campaign_product_leads/1").to route_to("campaign_product_leads#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/campaign_product_leads/1").to route_to("campaign_product_leads#destroy", :id => "1")
    end

  end
end
