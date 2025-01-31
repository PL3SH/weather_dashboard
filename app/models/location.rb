# Represents a geographical location with city, country, and coordinates
# Used to track weather records for specific places
class Location < ApplicationRecord
    has_many :weather_records
    validates :city, presence: true
    validates :country_code, presence: true, length: { is: 2 }
    validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
    validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

    # Returns the full name of the location in the format "City, Country Code"
    # @return [String] the location's full name
    def full_name
        "#{city}, #{country_code}"
    end

    # Returns only the city name of the location
    # @return [String] the location's city name
    def name
        "#{city}"
    end

    # Returns the geographical coordinates of the location
    # @return [String] the location's coordinates in "latitude, longitude" format
    def coordinates
        "#{latitude} , #{longitude}"
    end
end
