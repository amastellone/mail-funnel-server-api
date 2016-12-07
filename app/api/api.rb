class API < Grape::API
	prefix 'api'
	format :json

	puts "API LOADED AS /api/"
	# puts @key
	# puts @secret
	# puts @tokens

	def initialize

		super
	end

	helpers do

		def initvars
			puts 'INITIALIZED CONSTRUCTOR'
			Dotenv::Railtie.load
			# @key      = ENV['APP_KEY']
			# @secret   = ENV['APP_SECRET']
			# @appurl   = ENV['APP_URL']
			@key      = "84990ccf831cea238324340d512307d"
			@secret   = "18fb76db454fd01af035ebed69af51b6"
			@appurl   = "http://e90ef07a.ngrok.io/api/"
			@appname  = "mailfunnel-server"
			@appscope = ENV['APP_SCOPE']
			@tokens   = {}

			puts "HELPER VARS:"
			puts @key
			puts @secret
			puts @tokens
		end


		def current_user
			# @current_user ||= User.authorize!(env)
		end

		def authenticate!
			error!('401 Unauthorized', 401) unless current_user
		end

		def get_shop_access_token(shop, client_id, client_secret, code)
			if @tokens[shop].nil?
				url = "https://#{shop}/admin/oauth/access_token"

				payload = {
					 client_id:     client_id,
					 client_secret: client_secret,
					 code:          code }

				response = HTTParty.post(url, body: payload)
				# if the response is successful, obtain the token and store it in a hash
				if response.code == 200
					@tokens[shop] = response['access_token']
				else
					return [500, "Something went wrong."]
				end

				instantiate_session(shop)
			end
		end

		def instantiate_session(shop)
			# now that the token is available, instantiate a session
			session = ShopifyAPI::Session.initialize(shop, @tokens[shop])
			ShopifyAPI::Base.activate_session(session)
		end

		def validate_hmac(hmac, request)
			h      = params.reject { |k, _| k == 'hmac' || k == 'signature' }
			query  = URI.escape(h.sort.collect { |k, v| "#{k}=#{v}" }.join('&'))
			digest = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @secret, query)

			unless (hmac == digest)
				return [403, "Authentication failed. Digest provided was: #{digest}"]
			end
		end

		def verify_webhook(hmac, data)
			digest          = OpenSSL::Digest.new('sha256')
			calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, @secret, data)).strip

			hmac == calculated_hmac
		end

		def bulk_edit_url
			bulk_edit_url = "https://www.shopify.com/admin/bulk"\
                    "?resource_name=ProductVariant"\
                    "&edit=metafields.test.ingredients:string"
			return bulk_edit_url
		end

		def create_all_webhooks
			create_order_webhook
		end

		def create_order_webhook
			# create webhook for order creation if it doesn't exist
			unless ShopifyAPI::Webhook.find(:all).any?
				webhook = {
					 topic:   'cart/create',
					 address: "#{@appurl}cart/create",
					 format:  'json' }

				ShopifyAPI::Webhook.create(webhook)
				# TODO: CREATE ONE FOR EACH WEBHOOK
			end
		end

		def add_app(name)
			App.find_or_create_by(name: name)
		end
	end

	# SHOPIFY WEBHOOKS

	# STEP #1
	# http://localhost:3001/API/install
	get :install do
		initvars()

		add_app(params[:shop])

		shop   = params[:shop]
		scopes = "read_orders,read_products"

		puts "INSTALL KEY VARIABLE:"
		puts @key

		# construct the installation URL and redirect the merchant
		install_url = "http://#{shop}/admin/oauth/authorize?client_id=#{@key}"\
                "&scope=#{scopes}&redirect_uri=#{@appurl}auth"

		# redirect to the install_url
		redirect install_url
	end

	get :auth do
		initvars()

		# extract shop data from request parameters
		shop = params[:shop]
		code = params[:code]
		hmac = params[:hmac]

		# perform hmac validation to determine if the request is coming from Shopify
		validate_hmac(hmac, request)

		# if no access token for this particular shop exist,
		# POST the OAuth request and receive the token in the response
		get_shop_access_token(shop, @key, @secret, code)

		# create webhook for order creation if it doesn't exist
		create_all_webhooks

		# now that the session is activated, redirect to the bulk edit page
		redirect bulk_edit_url
	end

	resource :cart do
		get :create do
			initvars()
			shop  = params[:shop]
			email = params[:email]
			code  = params[:code]
			hmac  = params[:hmac]

			hmac = request.env['HTTP_X_SHOPIFY_HMAC_SHA256']

			request.body.rewind
			data       = request.body.read
			webhook_ok = verify_webhook(hmac, data)

			if webhook_ok
				shop  = request.env['HTTP_X_SHOPIFY_SHOP_DOMAIN']
				token = @tokens[shop]

				unless token.nil?
					session = ShopifyAPI::Session.initialize(shop, token)
					ShopifyAPI::Base.activate_session(session)
				else
					return [403, "You're not authorized to perform this action."]
				end
			else
				return [403, "You're not authorized to perform this action."]
			end


			# parse the request body as JSON data
			json_data = JSON.parse data

			line_items = json_data['line_items']

			line_items.each do |line_item|
				variant_id = line_item['variant_id']

				variant = ShopifyAPI::Variant.find(variant_id)

				variant.metafields.each do |field|
					if field.key == 'ingredients'
						items = field.split(',')

						items.each do |item|
							item = ShopifyAPI::Variant.find(item)

							session = ShopifyAPI::Session.setup({ :api_key => @key, :secret => @secret })
							# Get Item ID
							# Get Store that item belongs to
							# Check if hook exists for store
							# Identify Email-List By Store and Hook
							# Add Email to Email-List
						end

					end
				end
			end
		end

		# WEBHOOKS

		get '/cart/update' do
			ShopifyAPI::Session.setup(api_key: app.settings.api_key,
			                          secret: app.settings.shared_secret)

			shop  = params[:shop]
			email = params[:email]
			shop  = params[:shop]

			appname = ShopifyAPI::Shop.myshopify_domain
			customer = ShopifyAPI::Shop.customer_email


		end

		get '/checkouts/create' do
		end

		get '/checkouts/delete' do
		end

		get '/checkouts/update' do
		end
	end


	# REST API
	# URL Schema http://localhost:3000/api/jobs/all'

	resource :jobs do

		desc 'Returns Jobs for an App and Campaign'
		params do
			requires :id, type: Integer, desc: 'App ID'
			requires :campaign_identifier, type: String, desc: 'Local Campaign Identifier'
		end
		post do
			Job.where(app_id: params[:id], campaign_identifier: params[:campaign_identifier])
		end

		desc 'Adds a new Job.'

		params do
			# t.references :time, foreign_key: true # Delete this
			requires :frequency_time, type: Integer, desc: 'Value of the Frequency'
			requires :email_content, type: String, desc: 'Email Contents'
			requires :email_subject, type: String, desc: 'Email Subject'
			requires :email_list_id, type: Integer, desc: 'Email List ID.'
			# requires :user_local_id, type: Integer, desc: 'Local User ID'
			requires :hook_identifier, type: String, desc: 'Hook Identifier'
			requires :app_id, type: Integer, desc: 'App ID'
		end
		post do
			authenticate!

			Job.create(frequency_time: params[:frequency_time],
			           frequency_value: "execute_once", # execute_twice, execute_thrice
			           subject: params[:email_subject],
			           content: params[:email_content],
			           frequency: params[:frequency])
			           # TODO: finish adding params that are in controller
		end
	end

	resource :email_lists do
		desc 'Returns Email-Lists for an App'
		params do
			requires :id, type: Integer, desc: 'Shopify ID'
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
			requires :name, type: String, desc: 'Shopify Shop Name.'
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
			requires :app_id, type: Integer, desc: 'App_ID'
			requires :list_id, type: Integer, desc: 'List ID.'
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

		desc 'Get Hook ID'
		get :get_id
		params do
			requires :name, type: String, desc: 'Shopify App Name.'
		end
		route_param :id do
			get do
				result = App.where(name: params[:name]).first.id
			end
		end

		desc 'Returns All Hooks'
		get :get_hooks do
			Hook.limit(10)
		end
	end

	resource :apps do
		desc 'Get Shopify App ID from Shopify App name'
		get :get_id
		params do
			requires :name, type: String, desc: 'Shopify App Name.'
		end
		route_param :id do
			get do
				result = App.where(name: params[:name]).first.id
			end
		end

		desc 'Create Or Update App'
		get :create_app
		params do
			requires :name, type: String, desc: 'Shopify Shop Name.'
		end
		route_param :name do
			get do
				App.find_or_create_by(name: params[:name])
			end
		end
	end
end