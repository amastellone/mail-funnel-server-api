require "rails_helper"

RSpec.describe HooksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hooks").to route_to("hooks#index")
    end


    it "routes to #show" do
      expect(:get => "/hooks/1").to route_to("hooks#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/hooks").to route_to("hooks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/hooks/1").to route_to("hooks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/hooks/1").to route_to("hooks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hooks/1").to route_to("hooks#destroy", :id => "1")
    end

  end
end
