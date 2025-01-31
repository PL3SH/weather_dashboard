class WeatherRecord < ApplicationRecord
    belongs_to :location

    validates :temperature, presence: true
    validates :humidity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :description, presence: true
    validates :recorded_at, presence: true

    # this scope query all the recent registers of location
    scope :recent, -> { where("recorded_at >= ?", 30.minutes.ago) }

    def location_params
        params.permit(:city, :country_code)
    end
    # Returns the weather condition ID from OpenWeatherMap API
    # ID ranges and their meanings:
    # 200-232: Thunderstorm conditions
    # 300-321: Drizzle conditions
    # 500-531: Rain conditions
    # 600-622: Snow conditions
    # 701-781: Atmospheric conditions (mist, fog, etc.)
    # 800: Clear sky
    # 801-804: Cloud conditions
    # @return [Integer] weather condition ID
    # get the id_status to use in location view
    def id_status
      raw_data.dig("weather", 0, "id")
    end

   # def feels_like
   #     raw_data.dig("main", "feels_like")
   # end

   # this array stores the main keys that i would need to show data in my views
   MAIN_KEYS = [ "temp", "feels_like", "temp_min", "temp_max", "pressure", "humidity", "sea_level", "grnd_level" ]
   # using define method create methods to access the data easily
   MAIN_KEYS.each do |key|
     define_method(key.to_sym) do
       raw_data.dig("main", key)
     end
   end
end
