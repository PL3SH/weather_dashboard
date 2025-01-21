# app/services/weather_service.rb
class WeatherService
    include HTTParty
    base_uri 'api.openweathermap.org/data/2.5'
    
    def initialize
      @api_key = Rails.application.credentials.openweather[:api_key]
    end
    
    def fetch_weather(location)
      response = self.class.get("/weather", query: {
        lat: location.latitude,
        lon: location.longitude,
        appid: @api_key,
        units: 'metric'
      })
      
      return nil unless response.success?
      
      create_weather_record(location, response.parsed_response)
    end
    
    private
    
    def create_weather_record(location, data)
      WeatherRecord.create!(
        location: location,
        temperature: data.dig('main', 'temp'),
        humidity: data.dig('main', 'humidity'),
        description: data.dig('weather', 0, 'description'),
        recorded_at: Time.current,
        raw_data: data
      )
    end
  end