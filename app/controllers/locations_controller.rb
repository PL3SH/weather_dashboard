class LocationsController < ApplicationController
    def index
      @locations = Location.order(search_count: :desc)
    end
  
    def show
      @location = Location.find(params[:location_id])
      @current_weather = @location.weather_records.recent.first
    end
  
    def create
      @location = Location.new(location_params)
      
      if @location.save
        redirect_to @location, notice: 'Location was successfully saved.'
      else
        render :new
      end
    end
  
    def weather_history
      @location = Location.find(params[:location_id])
      @weather_records = @location.weather_records.order(recorded_at: :desc)
    end
  
    private
  
    def location_params
      params.require(:location).permit(:city, :country_code)
    end
  end