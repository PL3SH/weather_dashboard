
class WeatherController < ApplicationController
    def index
      
      @recent_locations = Location.order(search_count: :desc).limit(5)  # SELECT * FROM locations ORDER BY search_count DESC LIMIT 5 
     
      #esto nos devuelve una coleccion de la clase Location::ActiveRecord_Relation con un conjunto de 5 instacion de modelo location 
    end
    
    def search
      @location = find_or_create_location
      @weather = fetch_weather_data
      
     
      redirect_to location_path(@location.id)
    end
    
    private

    def find_or_create_location
        #usando el modelo location vamos a buscar en la base de datos si existe un registro en la base de datos con esos parametros, si existe lo retorna(va a tener un id) y si no, lo instacia(no tiene id) y lo guarda en la variable
      location = Location.find_or_initialize_by(
        city: location_params[:city],
        country_code: location_params[:country_code]
      )
      
      unless location.persisted? #persisted valida si el dato esta en base de datos si no ejecuta lo del bloque 
        coordinates = geocode_location(location_params[:city], location_params[:country_code])
        # aca deberia llegar el hash
        location.assign_attributes(coordinates)
        location.save!
      end
      
      location.increment!(:search_count)
      location
    end
    
    def fetch_weather_data
      cached_weather = @location.weather_records.recent.first
      return cached_weather if cached_weather.present?

      weather_service = WeatherService.new
      weather_service.fetch_weather(@location)
    end
    
    def location_params
      params.permit(:city, :country_code)
    end
    
    def geocode_location(city, country_code)
      # Implement geocoding logic here
      # You can use the geocoder gem or another geocoding service
      #search by city and country code by data and get the first element of the array
        geolocation_data = Geocoder.search("#{city}, #{country_code.downcase}").first

        latitude = geolocation_data&.latitude
        longitude = geolocation_data&.longitude
        
        { latitude: latitude, longitude: longitude }
      
    end

    def geocode_by_ip(ip)
      geolocation_data = Geocoder.search("#{ip}").first

        latitude = geolocation_data&.latitude
        longitude = geolocation_data&.longitude
        
        { latitude: latitude, longitude: longitude }
    end

    def fecth_public_ip #return in string the public IP
      response = HTTParty.get('https://api.ipify.org?format=json')
      JSON.parse(response.body)['ip'] if response.success?
      rescue => e
        Rails.logger.error("Error obteniendo IP pública: #{e.message}")
        nil
    end
  end