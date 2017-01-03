require 'rails_helper'

RSpec.describe "Hooks", type: :request do

  describe "GET /hooks" do

    # should not return http code 400 - Bad Request
    it "works! (now write some real specs)" do
      get hooks_path
      expect(response).to_not have_http_status(400)
    end


  end

end
