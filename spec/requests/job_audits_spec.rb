require 'rails_helper'

RSpec.describe "JobAudits", type: :request do
  describe "GET /job_audits" do
    it "works! (now write some real specs)" do
      get job_audits_path
      expect(response).to have_http_status(200)
    end
  end
end
