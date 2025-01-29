# Service class for interacting with the OpenWeatherMap API to fetch and store weather data.
#
# This service handles API requests to OpenWeatherMap, including rate limiting and data parsing.
# It uses HTTParty for making HTTP requests and Rails.cache for rate limiting.
#
# @example Fetching weather for a location
#   service = WeatherService.new
#   weather = service.fetch_weather(location)
#
class WeatherService
    include HTTParty
    base_uri 'api.openweathermap.org/data/2.5' 
    
    # Initializes the WeatherService with API credentials
    #
    # @return [WeatherService] a new instance of WeatherService
    def initialize
      @api_key = Rails.application.credentials.openweather[:api_key]
    end
    
    # Fetches current weather data for a given location
    #
    # Makes an API request to OpenWeatherMap and creates a new WeatherRecord
    # if the request is successful and within rate limits.
    #
    # @param location [Location] the location to fetch weather for
    # @return [WeatherRecord, nil] the created weather record or nil if the request fails
    # @example
    #   location = Location.find(1)
    #   weather_record = service.fetch_weather(location)
    def fetch_weather(location)
        return nil if rate_limit_exceeded?
        
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

    # Checks if the API rate limit has been exceeded
    #
    # Uses Rails.cache to track request count over a one-minute period
    #
    # @return [Boolean] true if rate limit exceeded, false otherwise
    # @api private
    def rate_limit_exceeded?
        requests = Rails.cache.read("api_requests_count") || 0
        if requests >= 60 # límite por minuto
          true
        else
          Rails.cache.increment("api_requests_count", 1, expires_in: 1.minute)
          false
        end
    end

    # Creates a new WeatherRecord from API response data
    #
    # @param location [Location] the location associated with the weather record
    # @param data [Hash] parsed JSON response from OpenWeatherMap API
    # @return [WeatherRecord] the created weather record
    # @raise [ActiveRecord::RecordInvalid] if record creation fails
    # @api private
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