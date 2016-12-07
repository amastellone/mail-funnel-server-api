MailFunnelServer::Application.routes.draw do

	# http://localhost:3001/API/
	mount API => '/'


	# http://localhost:3001/RESOURCE

  resources :email_lists do
	  # resources :email
	  resources :emails
  end

	resources :hooks
  resources :apps
  resources :jobs

end
