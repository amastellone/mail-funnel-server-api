Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  resources :hooks
  resources :email_lists
  resources :apps
  resources :jobs
  resources :emails
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
