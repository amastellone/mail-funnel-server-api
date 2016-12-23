require "rails_helper"

RSpec.describe MailFunnelServerConfigsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/mail_funnel_server_configs").to route_to("mail_funnel_server_configs#index")
    end


    it "routes to #show" do
      expect(:get => "/mail_funnel_server_configs/1").to route_to("mail_funnel_server_configs#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/mail_funnel_server_configs").to route_to("mail_funnel_server_configs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/mail_funnel_server_configs/1").to route_to("mail_funnel_server_configs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/mail_funnel_server_configs/1").to route_to("mail_funnel_server_configs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mail_funnel_server_configs/1").to route_to("mail_funnel_server_configs#destroy", :id => "1")
    end

  end
end
