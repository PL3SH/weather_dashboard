class WeatherRecord < ApplicationRecord
    belongs_to :Location

    validates :temperature, presence: true
    validates :humidity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :description, presence: true
    validates :recorded_at, presence: true


    scope :recent, -> { where('recorded_at >= ?', 30.minutes.ago) }
   

end