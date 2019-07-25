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

ActiveRecord::Schema.define(version: 2019_07_25_153819) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "city"
    t.string "state"
    t.string "state_code"
    t.string "zip"
    t.string "google_maps_url"
    t.string "lat"
    t.string "lon"
    t.integer "washer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "rating"
    t.text "comment"
    t.string "ip_address"
    t.integer "washer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.boolean "approved", default: false
    t.index ["ip_address", "washer_id"], name: "index_comments_on_ip_address_and_washer_id", unique: true
    t.index ["washer_id"], name: "index_comments_on_washer_id"
  end

  create_table "features", force: :cascade do |t|
    t.boolean "automatic"
    t.boolean "handwash"
    t.boolean "touchless"
    t.boolean "spray"
    t.boolean "interior"
    t.boolean "oil_change"
    t.boolean "shampoo"
    t.boolean "free_vacuum"
    t.integer "washer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "washers", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "website"
    t.string "primary_type"
    t.string "secondary_type"
    t.string "short_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified", default: false
    t.boolean "featured", default: false
  end

  create_table "working_days", force: :cascade do |t|
    t.string "sunday"
    t.string "monday"
    t.string "tuesday"
    t.string "wednesday"
    t.string "thursday"
    t.string "friday"
    t.string "saturday"
    t.integer "washer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
