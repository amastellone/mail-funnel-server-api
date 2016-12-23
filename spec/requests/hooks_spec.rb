require 'rails_helper'

RSpec.describe "Hooks", type: :request do
  describe "GET /hooks" do
    it "works! (now write some real specs)" do
      get hooks_path
      expect(response).to have_http_status(200)
    end
  end
end
