class CreateLocations < ActiveRecord::Migration[7.0]
    def change
        create_table :locations do |t|
            t.string :city, null: false
            t.string :country_code, null: false, limit: 2
            t.decimal :latitude, precision: 10, scale: 6, null: false
            t.decimal :longitude, precision: 10, scale: 6, null: false
            t.integer :search_count, default: 0

            t.timestamps

            t.index [ :city, :country_code ], unique:  true
        end
    end
end
