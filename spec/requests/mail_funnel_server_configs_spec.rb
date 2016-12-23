require 'rails_helper'

RSpec.describe "MailFunnelServerConfigs", type: :request do
  describe "GET /mail_funnel_server_configs" do
    it "works! (now write some real specs)" do
      get mail_funnel_server_configs_path
      expect(response).to have_http_status(200)
    end
  end
end
