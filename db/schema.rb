# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025012110301) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "city", null: false
    t.string "country_code", limit: 2, null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.integer "search_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city", "country_code"], name: "index_locations_on_city_and_country_code", unique: true
  end

  create_table "weather_records", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.decimal "temperature", precision: 5, scale: 2
    t.integer "humidity", null: false
    t.string "description", null: false
    t.datetime "recorded_at", null: false
    t.json "raw_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_weather_records_on_location_id"
    t.index ["recorded_at"], name: "index_weather_records_on_recorded_at"
  end

  add_foreign_key "weather_records", "locations"
end
