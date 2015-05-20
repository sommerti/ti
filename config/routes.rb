Rails.application.routes.draw do

  root to: 'trips#mytrips'
  
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  
  get "mytrips", to: 'trips#mytrips'

  resources :users
  
  resources :trips do
  	resources :stops
  end

end
