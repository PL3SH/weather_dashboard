# app/services/weather_service.rb
class WeatherService
    include HTTParty
    base_uri 'api.openweathermap.org/data/2.5' 
    
    def initialize
      @api_key = Rails.application.credentials.openweather[:api_key]
    end
    
    def fetch_weather(location)
        return nil if rate_limit_exceeded?
        #este response generara la url necesaria para hacer el fecth de datos, poniendo la ruta /weather y el querystring ?lat=location.latitude&lonlocation.longitude&appid=<la_api_key_que_creamos>&units:'metric'
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
    def rate_limit_exceeded?
        requests = Rails.cache.read("api_requests_count") || 0
        if requests >= 60 # límite por minuto
          true
        else
          Rails.cache.increment("api_requests_count", 1, expires_in: 1.minute)
          false
        end
    end

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