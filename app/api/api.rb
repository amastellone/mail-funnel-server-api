class API < Grape::API
	prefix 'api'
	format :json

	puts "API LOADED AS /api/"
	puts 
	# puts @key
	# puts session[:api_secret]
	# puts @tokens

	# Set everything in sessions
	# session[:api_key] 			= ENV['APP_KEY']
	# session[:api_secret] 			= ENV['APP_SECRET']
	# session[:api_url] 			= ENV['APP_URL']
	# session[:app_name] 			= ENV['APP_NAME']
	# session[:api_scope] 			= ENV['APP_SCOPE']

	def initialize

		super
	end

	helpers do

		def initvars
			puts 'INITIALIZED CONSTRUCTOR'
			Dotenv::Railtie.load
			@tokens   = {}
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
			# TODO: Replicate this with JWT Token Key
			app_secret = MailFunnelServerConfig.where(name: 'app_key').first.value
			h      = params.reject { |k, _| k == 'hmac' || k == 'signature' }
			query  = URI.escape(h.sort.collect { |k, v| "#{k}=#{v}" }.join('&'))
			digest = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), app_secret, query)

			unless (hmac == digest)
				return [403, "Authentication failed. Digest provided was: #{digest}"]
			end
		end

		def verify_webhook(hmac, data)
			app_secret = MailFunnelServerConfig.where(name: 'app_key').first.value
			digest          = OpenSSL::Digest.new('sha256')
			calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, app_secret, data)).strip

			hmac == calculated_hmac
		end

		# def bulk_edit_url
		# 	bulk_edit_url = "https://www.shopify.com/admin/bulk"\
  #                   "?resource_name=ProductVariant"\
  #                   "&edit=metafields.test.ingredients:string"
		# 	return bulk_edit_url
		# end

		def create_all_webhooks
			create_order_webhook
		end

		def create_order_webhook
			app_url = MailFunnelServerConfig.where(name: 'api_url').first.value
			# create webhook for order creation if it doesn't exist
			unless ShopifyAPI::Webhook.find(:all).any?
				webhook = {
					 topic:   'cart/create',
					 address: "#{app_url}cart/create",
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
		app_scope = MailFunnelServerConfig.where(name: 'app_scope').first.value

		app_key 	= MailFunnelServerConfig.where(name: 'app_key').first.value
		app_secret = MailFunnelServerConfig.where(name: 'app_key').first.value
		app_url = MailFunnelServerConfig.where(name: 'app_url').first.value


		# construct the installation URL and redirect the merchant
		install_url = "http://#{shop}/admin/oauth/authorize?client_id=#{app_secret}"\
                "&scope=#{app_scope}&redirect_uri=#{app_url}auth"

		# redirect to the install_url
		redirect install_url
	end

	get :auth do
		initvars()

		# extract shop data from request parameters
		shop = params[:shop]
		code = params[:code]
		hmac = params[:hmac]

		app_key = MailFunnelServerConfig.where(name: 'app_key').first.value
		app_secret = MailFunnelServerConfig.where(name: 'app_secret').first.value

		# perform hmac validation to determine if the request is coming from Shopify
		validate_hmac(hmac, request)

		# if no access token for this particular shop exist,
		# POST the OAuth request and receive the token in the response
		get_shop_access_token(shop, app_key, app_secret, code)

		# create webhook for order creation if it doesn't exist
		create_all_webhooks

		# now that the session is activated, redirect to the bulk edit page
		redirect bulk_edit_url
	end

	get 'cart_create' do

			log.info("Cart Create Hook")


			initvars()
			shop  = params[:shop]
			email = params[:email]
			code  = params[:code]
			hmac  = params[:hmac]

			app_key = MailFunnelServerConfig.where(name: 'app_key').first.value
			app_secret = MailFunnelServerConfig.where(name: 'app_secret').first.value

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

							session = ShopifyAPI::Session.setup({ :api_key => app_key, :secret => api_secret })
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

		get '/cart_update' do

			log.info("Cart Update Hook")

			ShopifyAPI::Session.setup(api_key: app.settings.api_key,
			                          secret: app.settings.shared_secret)

			shop  = params[:shop]
			email = params[:email]
			shop  = params[:shop]

			appname = ShopifyAPI::Shop.myshopify_domain
			customer = ShopifyAPI::Shop.customer_email


		end

		get '/checkout_create' do
		end

		get '/checkout_delete' do
		end

		get '/checkout_update' do
		end

	get '/metrics' do

		job_id = params[:job]
		# params[:sold]
		# params[:sale_ammount]
		email_id = params[:email]
		# params[:BuyDate]

		type = params[:type]
		pid = params[:pid]

		if type == 'product'

			app = App.where(name: ShopifyAPI::Store.current.name)
			job = Job.find(job_id)
			campaign = Campaign.find(job.campaign_id)
			email = Email.find(email_id)
			email_list = EmailList.find(email.email_list_id)


			lead = CampaignProductLead.new
			lead.app_id = app.id
			lead.campaign_id = campaign.id
			lead.product_identifier = pid
			lead.job_id = job_id
			lead.email_list_id = email_list.id
			lead.ClickDate = DateTime.now
			# TODO: Check if we want click count
			lead.save

			product = ShopifyAPI::Product.find(pid)
			redirect_to 'http://' + app.name + '/products/' + product.id #TODO: Check this works + http(s)
		end

	end

	get 'checkout_complete' do

		app = App.where(name: ShopifyAPI::Store.current.name)
		emails = Email.where(name: ShopifyAPI::Customer.current.email)
		products = params[:products]

		while p : products

			# Get the products iterate over all of them
			# Iterate over emails incase the email is on multiple lists
			# For each email, check if there is a lead
			# If there is, update the lead to SOLD and add the sale_price

			thisproduct = CampaignProductLead.where(app_id: app.id, product_identifier: p.id, email: email_id)

			end
		end

	end


	# REST API
	# URL Schema http://localhost:3000/api/jobs/all'

	resource :job_queue do

		desc 'Return Pending jobs in Resque Job queue for Job ID.'
		params do
			requires :id, type: Integer, desc: 'Job ID'
		end
		route_param :id do
			get do
				Status.find(params[:id])
			end
		end

	end

	# resource :email_lists do
	# 	desc 'Returns Email-Lists for an App'
	# 	params do
	# 		requires :id, type: Integer, desc: 'Shopify ID'
	# 	end
	# 	route_param :id do
	# 		get do
	# 			EmailList.where(app_id: params[:id])
	# 		end
	# 	end
	# end
end