require 'rails_helper'

RSpec.describe "Testmodels", :type => :request do
  describe "GET /testmodels" do
    it "works! (now write some real specs)" do
      get testmodels_path
      expect(response.status).to be(200)
    end
  end
end
