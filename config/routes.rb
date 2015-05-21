Rails.application.routes.draw do

  root to: "trips#trip_library"
  
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  
  get "my_trips", to: "trips#my_trips"
  get "trip_library", to: "trips#trip_library"

  resources :users
  
  resources :trips do
  	get "search_stop", to: "stops#search_stop"
  	resources :stops
  end

end
