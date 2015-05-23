Rails.application.routes.draw do

  get 'locations/new'

  get 'locations/create'

  get 'locations/edit'

  get 'locations/update'

  get 'locations/destroy'

  root to: "trips#trip_library"
  
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  
  get "my_trips", to: "trips#my_trips"
  get "trip_library", to: "trips#trip_library"

  resources :users
  
  resources :trips do
  	get "search_stop", to: "stops#search_stop"

  	member do
  		post "clone_trip", to: "trips#clone_trip"
      get "big_map", to: "trips#big_map"
  	end
  	
  	resources :stops
    resources :comments
    
  end

end
