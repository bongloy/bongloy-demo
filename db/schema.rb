# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_14_080207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tax_vehicles", force: :cascade do |t|
    t.string "plate_number"
    t.string "brand"
    t.string "type"
    t.string "color"
    t.string "engine_number"
    t.string "year"
    t.string "power"
    t.string "name"
    t.string "en_name"
    t.string "gender"
    t.string "birth_date"
    t.string "id_number"
    t.string "home"
    t.string "street"
    t.string "vilage"
    t.string "commune"
    t.string "district"
    t.string "city"
    t.string "email"
    t.string "phone_number"
    t.string "reference_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
