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

ActiveRecord::Schema.define(version: 20140501185120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "project_type"
    t.string   "region"
    t.string   "performer_type"
    t.string   "character"
    t.string   "pay"
    t.string   "union"
    t.string   "director"
    t.text     "story"
    t.text     "description"
    t.text     "audition"
    t.datetime "audition_date"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "paid",             default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "producers"
    t.string   "writers"
    t.string   "location"
    t.string   "casting_director"
  end

  add_index "events", ["audition_date"], name: "index_events_on_audition_date", using: :btree

  create_table "headshots", force: true do |t|
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "background", default: false, null: false
  end

  create_table "projects", force: true do |t|
    t.string   "project_type"
    t.string   "title"
    t.string   "role"
    t.string   "director_studio"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resumes", force: true do |t|
    t.integer  "height"
    t.integer  "weight"
    t.string   "hair_color"
    t.string   "eye_color"
    t.string   "phone"
    t.string   "unions"
    t.string   "agent_name"
    t.string   "agent_phone"
    t.string   "additional_skills"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "descriptive_tag"
    t.string   "gender"
    t.string   "hair_length"
    t.string   "piercing"
    t.string   "tattoo"
    t.string   "citizen"
    t.boolean  "passport"
    t.string   "phone_two"
    t.string   "manager_name"
    t.string   "manager_phone"
    t.string   "agent_email"
    t.string   "agent_location"
    t.string   "agent_location_two"
    t.string   "agent_city"
    t.string   "agent_state"
    t.string   "agent_zip"
    t.string   "agent_type"
  end

  create_table "schools", force: true do |t|
    t.string   "school"
    t.string   "major"
    t.string   "degree"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "teacher"
    t.integer  "years"
    t.string   "education_type"
    t.string   "instruments"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "location_address"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_zip"
    t.date     "birthday"
    t.boolean  "admin",                  default: false, null: false
    t.string   "location_address_two"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.text     "video_url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_thumb_url"
  end

end
