class CreateWeatherRecords < ActiveRecord::Migration[7.0]
    def change
        create_table :weather_records do |t|
          t.references :location, null: false, foreign_key: true
          t.decimal :temperature, precision: 5, scale: 2
          t.integer :humidity, null: false
          t.string :description, null: false
          t.datetime :recorded_at, null: false
          t.json :raw_data

          t.timestamps

          t.index :recorded_at
        end
    end
end
