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

ActiveRecord::Schema.define(version: 20150420165311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accents", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "athletic_endeavors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camper_registrations", force: true do |t|
    t.integer "camp_id",        null: false
    t.integer "order_id",       null: false
    t.string  "how_heard",      null: false
    t.string  "referral_name"
    t.string  "referral_email"
  end

  create_table "campers", force: true do |t|
    t.integer "camper_registration_id",                         null: false
    t.integer "user_id",                                        null: false
    t.string  "grade",                                          null: false
    t.string  "gender",                                         null: false
    t.string  "home_phone",                     default: "N/A", null: false
    t.string  "cell_phone",                                     null: false
    t.string  "emergency_contact_name"
    t.string  "emergency_contact_phone"
    t.string  "emergency_contact_relationship"
    t.text    "medical_history",                default: "N/A", null: false
    t.text    "medical_current_medication",     default: "N/A", null: false
    t.text    "medical_allergies",              default: "N/A", null: false
    t.string  "shirt_size",                                     null: false
    t.string  "school",                                         null: false
    t.string  "referred_by"
    t.boolean "agreed_to_refund_policy",        default: false, null: false
    t.boolean "photo_release",                  default: false, null: false
    t.boolean "agreed_to_medical_release",      default: false, null: false
  end

  create_table "campers_lists", force: true do |t|
    t.string  "user_email"
    t.integer "order_id"
    t.string  "code"
  end

  create_table "camps", force: true do |t|
    t.string "name", null: false
    t.string "code", null: false
  end

  create_table "conversations", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "subject"
    t.datetime "recent_message_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id", using: :btree

  create_table "critique_responses", force: true do |t|
    t.text     "body"
    t.integer  "critique_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "headshot_comment"
    t.text     "resume_comment"
    t.text     "improvement_comment"
    t.text     "overall_comment"
  end

  add_index "critique_responses", ["critique_id"], name: "index_critique_responses_on_critique_id", using: :btree
  add_index "critique_responses", ["user_id"], name: "index_critique_responses_on_user_id", using: :btree

  create_table "critiques", force: true do |t|
    t.string   "project_title"
    t.text     "notes"
    t.integer  "user_id"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "types"
    t.string   "stripe_charge_id"
    t.string   "payment_method"
  end

  add_index "critiques", ["user_id"], name: "index_critiques_on_user_id", using: :btree
  add_index "critiques", ["uuid"], name: "index_critiques_on_uuid", using: :btree

  create_table "disabilities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disability_assistive_devices", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ethnicities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_audition_dates", force: true do |t|
    t.integer  "event_id"
    t.date     "audition_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_unions", force: true do |t|
    t.integer  "event_id",   null: false
    t.integer  "union_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_unions", ["event_id"], name: "index_event_unions_on_event_id", using: :btree
  add_index "event_unions", ["union_id"], name: "index_event_unions_on_union_id", using: :btree

  create_table "events", force: true do |t|
    t.string    "project_title"
    t.text      "storyline"
    t.text      "how_to_audition"
    t.datetime  "start_date"
    t.boolean   "paid",                    default: false, null: false
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "location"
    t.text      "casting_director"
    t.integer   "region_id"
    t.integer   "project_type_id"
    t.text      "project_type_details"
    t.text      "special_notes"
    t.text      "additional_project_info"
    t.int4range "age_range"
    t.text      "staff"
    t.text      "pay_rate"
    t.text      "audition_times"
    t.text      "production_location"
    t.boolean   "stipend",                 default: false
    t.datetime  "audition_date"
    t.integer   "user_id"
    t.datetime  "end_date"
  end

  add_index "events", ["project_type_id"], name: "index_events_on_project_type_id", using: :btree
  add_index "events", ["region_id"], name: "index_events_on_region_id", using: :btree

  create_table "fluent_languages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "headshots", force: true do |t|
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "background",     default: false, null: false
    t.boolean  "resume_photo",   default: false, null: false
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.boolean  "profile_photo",  default: false, null: false
  end

  add_index "headshots", ["imageable_id", "imageable_type"], name: "index_headshots_on_imageable_id_and_imageable_type", using: :btree
  add_index "headshots", ["imageable_id"], name: "index_headshots_on_imageable_id", using: :btree

  create_table "mentor_bios", force: true do |t|
    t.string  "company"
    t.string  "company_address"
    t.integer "int_company_phone"
    t.string  "past_company"
    t.string  "current_projects"
    t.string  "teaching_experience"
    t.string  "talent_expertise",       default: [],    array: true
    t.string  "dance_style",            default: [],    array: true
    t.string  "education_experience"
    t.string  "artistic_organizations"
    t.integer "user_id"
    t.text    "biography"
    t.string  "company_phone"
    t.string  "hometown"
    t.boolean "associated_to_college",  default: false
    t.string  "college"
    t.string  "current_city"
    t.integer "region_id"
  end

  create_table "messages", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "body"
    t.datetime "recipient_read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "performance_skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "project_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_order"
  end

  create_table "projects", force: true do |t|
    t.string   "title"
    t.string   "role"
    t.string   "director_studio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_type_id"
    t.integer  "resume_id"
  end

  add_index "projects", ["project_type_id"], name: "index_projects_on_project_type_id", using: :btree
  add_index "projects", ["resume_id"], name: "index_projects_on_resume_id", using: :btree

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_accents", force: true do |t|
    t.integer  "resume_id"
    t.integer  "accent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_athletic_endeavors", force: true do |t|
    t.integer  "resume_id"
    t.integer  "athletic_endeavor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_disabilities", force: true do |t|
    t.integer  "resume_id"
    t.integer  "disability_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_disability_assistive_devices", force: true do |t|
    t.integer  "resume_id"
    t.integer  "disability_assistive_device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_ethnicities", force: true do |t|
    t.integer  "resume_id"
    t.integer  "ethnicity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_fluent_languages", force: true do |t|
    t.integer  "resume_id"
    t.integer  "fluent_language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_performance_skills", force: true do |t|
    t.integer  "resume_id"
    t.integer  "performance_skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_unions", force: true do |t|
    t.integer  "resume_id",  null: false
    t.integer  "union_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resume_unions", ["resume_id"], name: "index_resume_unions_on_resume_id", using: :btree
  add_index "resume_unions", ["union_id"], name: "index_resume_unions_on_union_id", using: :btree

  create_table "resumes", force: true do |t|
    t.integer  "height"
    t.integer  "weight"
    t.string   "hair_color"
    t.string   "eye_color"
    t.string   "phone"
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
    t.string   "slug"
  end

  add_index "resumes", ["slug"], name: "index_resumes_on_slug", unique: true, using: :btree

  create_table "role_performance_skills", force: true do |t|
    t.integer "role_id"
    t.integer "performance_skill_id"
  end

  add_index "role_performance_skills", ["performance_skill_id"], name: "index_role_performance_skills_on_performance_skill_id", using: :btree
  add_index "role_performance_skills", ["role_id"], name: "index_role_performance_skills_on_role_id", using: :btree

  create_table "roles", force: true do |t|
    t.text      "description"
    t.string    "gender"
    t.string    "ethnicity"
    t.int4range "age_range"
    t.integer   "event_id"
    t.datetime  "created_at"
    t.datetime  "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "school"
    t.string   "major"
    t.string   "degree"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "teacher"
    t.integer  "years"
    t.string   "education_type"
    t.text     "instruments"
    t.integer  "resume_id"
    t.text     "acting"
    t.text     "dance"
    t.text     "voice"
    t.text     "stage_combat"
  end

  add_index "schools", ["resume_id"], name: "index_schools_on_resume_id", using: :btree

  create_table "unions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "parent_name"
    t.string   "parent_email"
    t.string   "parent_location"
    t.string   "parent_location_two"
    t.string   "parent_city"
    t.string   "parent_state"
    t.string   "parent_zip"
    t.string   "parent_phone"
    t.boolean  "mentor",                 default: false, null: false
    t.string   "stripe_customer_id"
    t.string   "stripe_plan_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["stripe_customer_id"], name: "index_users_on_stripe_customer_id", using: :btree

  create_table "videos", force: true do |t|
    t.text     "video_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_thumb_url"
    t.integer  "videoable_id"
    t.string   "videoable_type"
    t.string   "video"
    t.integer  "video_job_id"
    t.string   "video_job_status"
    t.integer  "video_width"
    t.integer  "video_height"
    t.string   "video_tmp"
  end

  add_index "videos", ["videoable_id", "videoable_type"], name: "index_videos_on_videoable_id_and_videoable_type", using: :btree
  add_index "videos", ["videoable_id"], name: "index_videos_on_videoable_id", using: :btree

end
