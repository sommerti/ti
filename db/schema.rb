# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150523014254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.integer "country_id",            null: false
    t.integer "region_id",             null: false
    t.string  "name",       limit: 45, null: false
    t.float   "latitude",              null: false
    t.float   "longitude",             null: false
    t.string  "timezone",   limit: 10, null: false
    t.integer "dma_id"
    t.string  "code",       limit: 4
  end

  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "trip_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string  "name",                 limit: 50,  null: false
    t.string  "fips104",              limit: 2,   null: false
    t.string  "iso2",                 limit: 2,   null: false
    t.string  "iso3",                 limit: 3,   null: false
    t.string  "ison",                 limit: 4,   null: false
    t.string  "internet",             limit: 2,   null: false
    t.string  "capital",              limit: 25
    t.string  "map_reference",        limit: 50
    t.string  "nationality_singular", limit: 35
    t.string  "nationality_plural",   limit: 35
    t.string  "currency",             limit: 30
    t.string  "currency_code",        limit: 3
    t.integer "population"
    t.string  "title",                limit: 50
    t.string  "comment",              limit: 255
  end

  add_index "countries", ["name"], name: "index_countries_on_name", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "trip_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "begin_date"
    t.date     "end_date"
    t.text     "description"
  end

  create_table "regions", force: :cascade do |t|
    t.integer "country_id",            null: false
    t.string  "name",       limit: 45, null: false
    t.string  "code",       limit: 8,  null: false
    t.string  "adm1code",   limit: 4,  null: false
  end

  add_index "regions", ["name"], name: "index_regions_on_name", using: :btree

  create_table "stops", force: :cascade do |t|
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "city_id"
    t.date     "begin_date"
    t.date     "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "trip_id"
    t.integer  "position"
    t.text     "description"
    t.integer  "row_order"
  end

  add_index "stops", ["city_id"], name: "index_stops_on_city_id", using: :btree
  add_index "stops", ["country_id"], name: "index_stops_on_country_id", using: :btree
  add_index "stops", ["region_id"], name: "index_stops_on_region_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.string   "name"
    t.date     "begin_date"
    t.date     "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.string   "slug"
    t.integer  "user_id"
    t.boolean  "is_private"
  end

  add_index "trips", ["slug"], name: "index_trips_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "country"
    t.string   "city"
    t.integer  "age"
    t.string   "gender"
    t.string   "role"
    t.string   "slug"
    t.text     "description"
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "delete_avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "cities", "countries"
  add_foreign_key "cities", "regions"
  add_foreign_key "regions", "countries"
  add_foreign_key "stops", "cities"
  add_foreign_key "stops", "countries"
  add_foreign_key "stops", "regions"
end
