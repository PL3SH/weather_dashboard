
class WeatherController < ApplicationController
    def index
      @recent_locations = Location.order(search_count: :desc).limit(6)  # SELECT * FROM locations ORDER BY search_count DESC LIMIT 5

     
      #this return us a Location::ActiveRecord_Relation collection with 6 instances of location model
    end
    #search looks in the db if exist a weather record about a location, if not then create the location and fecth the weather data
    def search
      @location = find_or_create_location
      @weather = fetch_weather_data
      redirect_to location_path(@location.id)
    end

    private

    def find_or_create_location
      #using location model i will seach in the DB if any register exist with this params if exist return it if not  instance one(dont have ID) and save in the variable
      
      location = Location.find_or_initialize_by(
        city: location_params[:city],
        country_code: location_params[:country_code]
      )

      unless location.persisted? # persisted valida si el dato esta en base de datos si no ejecuta lo del bloque persited validates if data is in BD if not exec exec this code
        coordinates = geocode_location(location_params[:city], location_params[:country_code])
        # here we get dicc 
        location.assign_attributes(coordinates)
        location.save!
      end
      
      location.increment!(:search_count)
      location
    end

    def fetch_weather_data
      #in case we have data about locations and weather record we load this
      cached_weather = @location.weather_records.recent.first
      return cached_weather if cached_weather.present?
      #if not we use the weather service to get the data
      weather_service = WeatherService.new
      weather_service.fetch_weather(@location)
    end

    def location_params
      params.permit(:city, :country_code)
    end

    def geocode_location(city, country_code)
        # Implement geocoding logic here
        # You can use the geocoder gem or another geocoding service
        # search by city and country code by data and get the first element of the array
        geolocation_data = Geocoder.search("#{city}, #{country_code.downcase}").first
        #return in a hash the latitude and longitude data
        { latitude: geolocation_data&.latitude, longitude: geolocation_data&.longitude }
    end

    def geocode_by_ip(ip)
      geolocation_data = Geocoder.search("#{ip}").first

        latitude = geolocation_data&.latitude
        longitude = geolocation_data&.longitude

        { latitude: latitude, longitude: longitude }
    end

    def fecth_public_ip # return in string the public IP
      response = HTTParty.get("https://api.ipify.org?format=json")
      JSON.parse(response.body)["ip"] if response.success?
      rescue => e
        Rails.logger.error("Error obteniendo IP pública: #{e.message}")
        nil
    end
end
