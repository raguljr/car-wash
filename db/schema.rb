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

ActiveRecord::Schema.define(version: 2019_04_19_061615) do

  create_table "washers", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "website"
    t.string "primary_type"
    t.string "secondary_type"
    t.string "short_address"
    t.string "city"
    t.string "state"
    t.string "state_code"
    t.string "zip"
    t.string "google_maps_url"
    t.string "lat"
    t.string "lon"
    t.boolean "automatic"
    t.boolean "handwash"
    t.boolean "touchless"
    t.boolean "spray"
    t.boolean "interior"
    t.boolean "oil_change"
    t.boolean "shampoo"
    t.boolean "free_vacuum"
    t.string "sunday"
    t.string "monday"
    t.string "tuesday"
    t.string "wednesday"
    t.string "thursday"
    t.string "friday"
    t.string "saturday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
