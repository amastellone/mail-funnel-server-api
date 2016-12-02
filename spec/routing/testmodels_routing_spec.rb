require "rails_helper"

RSpec.describe TestmodelsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/testmodels").to route_to("testmodels#index")
    end

    it "routes to #new" do
      expect(:get => "/testmodels/new").to route_to("testmodels#new")
    end

    it "routes to #show" do
      expect(:get => "/testmodels/1").to route_to("testmodels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/testmodels/1/edit").to route_to("testmodels#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/testmodels").to route_to("testmodels#create")
    end

    it "routes to #update" do
      expect(:put => "/testmodels/1").to route_to("testmodels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/testmodels/1").to route_to("testmodels#destroy", :id => "1")
    end

  end
end
