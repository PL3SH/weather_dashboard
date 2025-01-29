class WeatherRecord < ApplicationRecord
    belongs_to :location

    validates :temperature, presence: true
    validates :humidity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :description, presence: true
    validates :recorded_at, presence: true


    scope :recent, -> { where('recorded_at >= ?', 30.minutes.ago) }
   
    def location_params
        params.permit(:city, :country_code)
    end
    def id_status
      raw_data.dig("weather",0,"id")
    end

    # def feels_like
    #     raw_data.dig("main", "feels_like")
    # end


   MAIN_KEYS = ["temp", "feels_like", "temp_min", "temp_max", "pressure", "humidity", "sea_level", "grnd_level"]

   MAIN_KEYS.each do |key|
     define_method(key.to_sym) do
       raw_data.dig("main", key)
     end
   end
   
end