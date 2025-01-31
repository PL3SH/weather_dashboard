Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

# Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
# get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
# get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
=begin
  #weather_dashboard
  #rutas RESTful
  get "/weather", to: "weather#index", as:  :weather_index #index is for showing a collection of ellements and dont require an id
  , the alias let me to call into the code to the path using the methods created automatically <alias>_path o <alias>_url (weather_index_path, weather_index_url)  so i dont need to put the _path or _url
  post "/weather", to: "weather#create",  #create is a collection type route because this dont need an id
  get "/weather/new", to: "weather#new", as :new_weather #new is a collection route
  get "/weather/id", to: "weather#show" , as :weather #show is a member type route because i need to give a id to know what resource im refering
  get "/weather/id/edit", to: "weather#edit" ,a as :edit_weather #edit is a member type route because  i need to give a id to know what resource im refering
  put "/weather/id" , to: "weather#update" #update is a member type route
  delete "/weather/id", to: "weather#destroy" #destroy is a member type route
=end

  # Defines the root path route ("/")
  root "weather#index"

  # Weather routes
  resources :weather, only: [ :index ] do
    # create route of type collection
    collection do
      get "search"    # For GET requests (displaying search form)
      post "search"   # For POST requests (processing searches)
    end
  end

  # params = {id: value, algo: value}

  # Location routes - for managing saved locations
  resources :locations, only: [ :index, :show, :create ], param: :location_id do
    # create route of type member
    member do
      get "weather_history"
    end
  end
end
