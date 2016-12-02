MailFunnelServer::Application.routes.draw do

  resources :testmodels
	# root :to => 'home#index'

	# mount MailFunnel::API => '/'
	mount API => '/'

  # resources :hooks
  resources :email_lists
	resources :email
  resources :apps
  resources :jobs
  resources :emails
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
