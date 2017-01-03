# require 'rails_helper'
#
# # Request Spec Docs
# # http://matthewlehner.net/rails-api-testing-guidelines/
# # https://www.relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec
#
# RSpec.describe "Apps", type: :request do
#
# 	let(:valid_attributes) {
# 		# Valid attributes are generated using FactoryGirl
# 		FactoryGirl.attributes_for(:app)
# 	}
#
# 	let(:invalid_attributes) {
# 		{ name: nil }
# 	}
#
# 	let(:valid_session) { {} }
#
# 	describe "GET /apps" do
#
# 		it "gets an app by name" do
#       get "/api/v1/messages/#{message.id}"
# 			get apps_path
# 			expect(response).to have_http_status(200)
# 		end
# 	end
#
# 	describe "POST /apps/new" do
# 		it "creates an App" do
# 			headers = {
# 				 "ACCEPT"      => "application/json", # This is what Rails 4 accepts
# 				 "HTTP_ACCEPT" => "application/json" # This is what Rails 3 accepts
# 			}
# 			post "/apps", { :app => { :name => "test-app-name" } }, headers
#
# 			expect(response.content_type).to eq("application/json")
# 			expect(response).to have_http_status(:created)
# 		end
# 	end
#
# end
#
# # Run ' rake routes | grep "apps#" ' to see all Apps Routes that need testing (then clean it up)
#
# # GET    /apps(.:format)                                                           apps#index
# # POST   /apps(.:format)                                                           apps#create
# # GET    /apps/:id(.:format)                                                       apps#show
# # PATCH  /apps/:id(.:format)                                                       apps#update
# # PUT    /apps/:id(.:format)                                                       apps#update
# # DELETE /apps/:id(.:format)                                                       apps#destroy
#
#
