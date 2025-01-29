class Location < ApplicationRecord
    has_many :weather_records
    validates :city, presence: true
    validates :country_code, presence: true, length: {is:2}
    validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
    validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }



    def full_name
        "#{city}, #{country_code}"
    end

    def coordinates
        "#{latitude} , #{longitude}"
    end
end