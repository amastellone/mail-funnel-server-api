module Mailfunnel
	class API < Grape::API

		helpers do
			def current_user
				@current_user ||= User.authorize!(env)
			end

			def authenticate!
				error!('401 Unauthorized', 401) unless current_user
			end
		end

		resource :jobs do
			desc 'Returns Jobs for an App'
			params do
				requires :id, type: Integer, desc: 'App ID.'
			end
			route_param :id do
				get do
					Job.where(app_id: params[:id])
				end
			end

			desc 'Adds a new Job.'
			params do
				# t.references :time, foreign_key: true
				# t.string :subject
				# t.text :content
				# t.references :email_list_id, foreign_key: true
				# t.references :app_id, foreign_key: true
				# t.references :hook_id, foreign_key: true
				# t.integer :user_local_id
				# TODO: Change frequency to single value - time from trigger to send email
				requires :frequency, type: String, desc: 'Set Time as String'
				requires :frequency_value, type: Integer, desc: 'Value of the Frequency'
				# requires :email, type: String, desc: 'Email'
				requires :content, type: String, desc: 'Content'
				requires :email_list_id, type: Integer, desc: 'Email List ID.'
				requires :user_local_id, type: Integer, desc: 'Local User ID'
				requires :hook_id, type: Integer, desc: 'List ID.'
				requires :app_id, type: String, desc: 'App_ID'
				requires :list_id, type: String, desc: 'List ID.'
			end
			post do
				authenticate!
				Email.create!({ name: params[:name], email: params[:email], app_id: params[:status], list_id: params[:list_id], })
			end
		end

		resource :email_lists do
			desc 'Returns Email-Lists for an App'
			params do
				requires :id, type: Integer, desc: 'App ID.'
			end
			route_param :id do
				get do
					EmailList.where(app_id: params[:id])
				end
			end

		end
		resource :emails do
			desc 'Returns List of Emails'
			params do
				requires :id, type: Integer, desc: 'Email-List ID.'
			end
			route_param :id do
				get do
					Email.where(list_id: params[:id])
				end
			end

			desc 'Add an Email.'
			params do
				requires :name, type: String, desc: 'Name Update'
				requires :email, type: String, desc: 'Email update'
				requires :app_id, type: String, desc: 'App_ID'
				requires :list_id, type: String, desc: 'List ID.'
			end
			post do
				authenticate!
				Email.create!({ name: params[:name], email: params[:email], app_id: params[:status], list_id: params[:list_id], })
			end

			desc 'Add or Update an email.'
			params do
				requires :id, type: Integer, desc: 'Email ID. Leave blank for new'
				requires :name, type: String, desc: 'Name Update'
				requires :email, type: String, desc: 'Email update'
				requires :app_id, type: String, desc: 'App_ID'
				requires :list_id, type: String, desc: 'List ID.'
			end
			put ':id' do
				authenticate!
				if params[:id] == 0
					Email.create!({ name: params[:name], email: params[:email], app_id: params[:status], list_id: params[:list_id], })
				else
					Email.find(params[:id]).update({ id: params[:id], text: params[:status] })
				end
			end

			desc 'Delete an Email.'
			params do
				requires :id, type: String, desc: 'Email ID.'
			end
			delete ':id' do
				authenticate!
				Email.find(params[:id]).destroy
			end
		end

		resource :hooks do
			desc 'Returns All Hooks'
			get :get_hooks do
				Hook.limit(10)
			end
		end

		resource :apps do
			desc 'Verify if App is Valid by validating API Keys'
			get :verify_app
			params do
				requires :app_id, type: Integer, desc: 'App ID.'
				requires :shopify_api, type: String, desc: 'Shopify API KEY.'
			end
			route_param :id do
				get do
					App.where(id: params[:app_id]).any?
					# TODO: Second layer auth
				end
			end

			desc 'Create App'
			get :create_app
			params do
				requires :shopify_key, type: String, desc: 'Shopify Key.'
				requires :name, type: String, desc: 'Shopify Shop Name.'
			end
			route_param :id do
				get do
					App.create(shopify_key: params[:shopify_key], shopify_name: params[:shopify_name])
				end
			end
		end
	end
end