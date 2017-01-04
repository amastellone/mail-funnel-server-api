MailFunnelServer::Application.routes.draw do

  resources :campaigns
	# http://localhost:3001/API/
	mount API => '/'

	# http://localhost:3001/RESOURCE

	resources :email_lists do
		resources :emails
	end

	resources :emails

	resources :hooks

	resources :apps do
		resources :jobs do
			resources :email_lists do
				resources :email
			end
		end
		resources :email_lists do
			resources :email
		end
	end

	resources :jobs

end
