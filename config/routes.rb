Rails.application.routes.draw do
  root to: 'welcome#index'
  
  devise_for :users
  
  get "mytrips", to: 'trips#mytrips'

  resources :trips do
  	resources :stops
  end

end
