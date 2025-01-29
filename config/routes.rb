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
  get  "/weather", to: "weather#index", as:  :weather_index  #index es para mostrar una coleccion de elementos y no requiere un id especifico
  , el alias me permite llamar dentro de mi codigo a la ruta utilizando los metodos <alias>_path o <alias>_url (weather_index_path, weather_index_url) se crean automaticamente no tngo que poner el _url o _path
  post "/weather", to: "weather#create",  #create es una ruta de tipo collection por que no necesita un id
  get "/weather/new", to: "weather#new", as :new_weather #new es una ruta de tipo collection
  get "/weather/id", to: "weather#show" , as :weather #show es una ruta de tipo member por que necesito darle un id para que sepa a cual recurso me refiero
  get "/weather/id/edit", to: "weather#edit" ,a as :edit_weather #edit es una ruta de tipo member por que necesito darle un id para que sepa a cual recurso me refiero
  put "/weather/id" , to: "weather#update" #update es una ruta de tipo member por que necesito darle un id para que sepa a cual recurso me refiero
  delete "/weather/id", to: "weather#destroy" #destroy es una ruta de tipo member por que necesito darle un id para que sepa a cual recurso me refiero
=end


  root 'weather#index'
  
  # Weather routes
  resources :weather, only: [:index] do
    collection do
      get 'search'    # For GET requests (displaying search form)
      post 'search'   # For POST requests (processing searches)
    end
  end

  #params = {id: value, algo: value}
  
  # Location routes - for managing saved locations
  resources :locations, only: [:index, :show, :create], param: :location_id do
    member do
      get 'weather_history'
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
