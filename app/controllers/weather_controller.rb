# app/controllers/weather_controller.rb
class WeatherController < ApplicationController
    def index
      @recent_locations = Location.order(search_count: :desc).limit(5)
    end
    
    def search
      @location = find_or_create_location
      @weather = fetch_weather_data
      
      respond_to do |format|
        format.html { render partial: 'weather_info' if request.xhr? }
        format.json { render json: @weather }
      end
    end
    
    private
    
    def find_or_create_location
      location = Location.find_or_initialize_by(
        city: location_params[:city],
        country_code: location_params[:country_code]
      )
      
      unless location.persisted?
        coordinates = geocode_location(location_params[:city], location_params[:country_code])
        location.assign_attributes(coordinates)
        location.save!
      end
      
      location.increment!(:search_count)
      location
    end
    
    def fetch_weather_data
      weather_service = WeatherService.new
      cached_weather = @location.weather_records.recent.first
      
      return cached_weather if cached_weather.present?
      weather_service.fetch_weather(@location)
    end
    
    def location_params
      params.require(:location).permit(:city, :country_code)
    end
    
    def geocode_location(city, country_code)
      # Implement geocoding logic here
      # You can use the geocoder gem or another geocoding service
    end
  end