Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  
  authenticated :user do
    root to: "trips#trip_library", as: :authenticated_root
  end
  root to: 'welcome#index'


  
  get "my_trips", to: "trips#my_trips"
  get "trip_library", to: "trips#trip_library"

  resources :users
  
  resources :trips do
  	get "search_stop", to: "stops#search_stop"
    get "create_stop", to: "stops#create"

  	member do
  		post "clone_trip", to: "trips#clone_trip"
      get "big_map", to: "trips#big_map"
  	end
  	
  	resources :stops
    resources :locations
    resources :comments
    
  end

end
