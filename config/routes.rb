MailFunnelServer::Application.routes.draw do

  resources :campaign_product_leads
  resources :job_queues
  resources :campaigns do
	  resources :hooks
  end
	# http://localhost:3001/API/
	mount API => '/'

	# http://localhost:3001/RESOURCE

	resources :email_lists do
		resources :emails
	end

	resources :emails
  resources :jobs
	resources :hooks

	resources :apps do
		resources :campaigns do
			resources :email_lists do
				resources :email
			end
			resources :jobs
		end
		resources :email_lists do
			resources :email
		end
	end


end
