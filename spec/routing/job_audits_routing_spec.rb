require "rails_helper"

RSpec.describe JobAuditsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/job_audits").to route_to("job_audits#index")
    end


    it "routes to #show" do
      expect(:get => "/job_audits/1").to route_to("job_audits#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/job_audits").to route_to("job_audits#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/job_audits/1").to route_to("job_audits#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/job_audits/1").to route_to("job_audits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/job_audits/1").to route_to("job_audits#destroy", :id => "1")
    end

  end
end
