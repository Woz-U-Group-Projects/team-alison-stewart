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

ActiveRecord::Schema.define(version: 2018120132255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "CUSTOMER", id: false, force: :cascade do |t|
    t.string "ID"
    t.string "ADDR_1"
    t.string "ADDR_2"
    t.string "ADDR_3"
    t.string "CITY"
    t.string "STATE"
    t.string "ZIPCODE"
    t.string "COUNTRY"
    t.string "CONTACT_FIRST_NAME"
    t.string "CONTACT_LAST_NAME"
    t.string "CONTACT_PHONE"
    t.string "CONTACT_FAX"
    t.string "CONTACT_MOBILE"
    t.string "CONTACT_EMAIL"
    t.string "NAME"
    t.string "DISCOUNT_CODE"
    t.string "FREE_ON_BOARD"
  end

  create_table "USER_DEF_FIELDS", id: false, force: :cascade do |t|
    t.string  "ROWID"
    t.string  "DOCUMENT_ID"
    t.string  "ID"
    t.string  "STRING_VAL"
    t.string  "UDF-0000014"
    t.string  "UDF-0000015"
    t.date    "UDF-0000017"
    t.boolean "UDF-0000018"
    t.boolean "UDF-0000019"
    t.boolean "UDF-0000020"
    t.string  "UDF-0000021"
    t.string  "UDF-0000022"
    t.date    "UDF-0000023"
    t.string  "UDF-0000027"
    t.string  "UDF-0000029"
    t.string  "UDF-0000030"
    t.string  "UDF-0000173"
    t.integer "UDF-0000177"
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_type",  null: false
    t.integer  "owner_id",    null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.string   "customer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_student"
    t.string   "email_parent"
    t.string   "phone_student"
    t.string   "phone_parent"
    t.string   "student_number"
    t.integer  "height_ft"
    t.integer  "height_in"
    t.string   "gender"
    t.string   "sitting_type"
    t.string   "faculty_school_code"
    t.boolean  "uploaded"
    t.datetime "uploaded_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",               default: "pending", null: false
    t.string   "graduation_year"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "owner_id",    null: false
    t.string   "owner_type",  null: false
    t.string   "text",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_text"
  end

  create_table "contact_requests", force: :cascade do |t|
    t.string   "to_emails",  null: false
    t.string   "from_email", null: false
    t.string   "subject",    null: false
    t.string   "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "convocations", force: :cascade do |t|
    t.datetime "ceremony",   null: false
    t.integer  "school_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demo_videos", force: :cascade do |t|
    t.string   "title",             null: false
    t.string   "description",       null: false
    t.string   "video_url",         null: false
    t.string   "still_screen"
    t.integer  "event_type_id",     null: false
    t.string   "grad_program_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grad_group_code"
  end

  add_index "demo_videos", ["event_type_id", "grad_program_code"], name: "index_demo_videos_on_event_type_id_and_grad_program_code", unique: true, using: :btree

  create_table "electronic_marketings", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "program_slug",            null: false
    t.string   "name",                    null: false
    t.string   "file",                    null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grad_program_code"
    t.string   "grad_group_code"
    t.string   "school_day_program_code"
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title",            null: false
    t.string   "employee_code"
    t.string   "telephone_number"
    t.string   "extension"
    t.string   "cellphone_number"
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "description"
  end

  create_table "event_types", force: :cascade do |t|
    t.string   "highrise_field", null: false
    t.string   "code",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "program_slug"
    t.integer  "position"
  end

  create_table "events", force: :cascade do |t|
    t.string   "date"
    t.integer  "school_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_type_id", null: false
  end

  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
  add_index "events", ["school_id", "event_type_id"], name: "index_events_on_school_id_and_event_type_id", unique: true, using: :btree
  add_index "events", ["school_id"], name: "index_events_on_school_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "title"
    t.string   "icon"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "from_email"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "frequently_asked_question_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frequently_asked_questions", force: :cascade do |t|
    t.text     "question",                          null: false
    t.text     "answer",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "frequently_asked_question_type_id"
  end

  create_table "gateway_transactions", force: :cascade do |t|
    t.integer  "amount"
    t.string   "action"
    t.boolean  "success"
    t.string   "reference"
    t.text     "message"
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "id_card_replacement_requests", force: :cascade do |t|
    t.string   "request_type"
    t.string   "passcode"
    t.string   "school"
    t.string   "attention_of"
    t.string   "attention_of_email"
    t.string   "student_fname"
    t.string   "student_lname"
    t.string   "student_homeroom"
    t.string   "student_grade"
    t.string   "student_number"
    t.string   "id_barcode"
    t.text     "reason_for_reprint"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "id_card_requests", force: :cascade do |t|
    t.integer  "school_id",                               null: false
    t.string   "attention_of",                            null: false
    t.string   "attention_of_email",                      null: false
    t.string   "state",               default: "pending", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "result_photo"
    t.string   "uuid",                                    null: false
    t.string   "result_pdf"
    t.string   "student_number"
    t.integer  "id_card_template_id",                     null: false
    t.string   "student_name"
  end

  create_table "id_card_templates", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "base_photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       null: false
  end

  add_index "id_card_templates", ["school_id"], name: "index_id_card_templates_on_school_id", using: :btree

  create_table "important_date_type_programs", force: :cascade do |t|
    t.integer  "important_date_type_id", null: false
    t.string   "program_slug",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "important_date_types", force: :cascade do |t|
    t.string   "highrise_field", null: false
    t.string   "code",           null: false
    t.string   "name"
    t.boolean  "dynamic_name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "important_dates", force: :cascade do |t|
    t.integer  "school_id",              null: false
    t.integer  "important_date_type_id", null: false
    t.string   "name",                   null: false
    t.string   "value",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_postings", force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "title"
    t.integer  "job_type_id"
    t.text     "responsibilities"
    t.text     "requirements"
    t.datetime "expiry_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "job_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "job_types", ["name"], name: "index_job_types_on_name", unique: true, using: :btree

  create_table "look_books", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_id",   null: false
    t.string   "title"
    t.string   "program_slug"
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "type",                             null: false
    t.integer  "owner_id",                         null: false
    t.string   "owner_type",                       null: false
    t.integer  "x",                                null: false
    t.integer  "y",                                null: false
    t.integer  "width",                            null: false
    t.integer  "height",                           null: false
    t.string   "font_family"
    t.integer  "point_size"
    t.string   "node_photo"
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_width"
    t.integer  "crop_height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "color",        default: "#000000"
    t.string   "junior_field"
    t.integer  "position"
    t.string   "alignment"
    t.string   "mask"
    t.boolean  "uppercase",    default: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "uuid",                   null: false
    t.integer  "amount",                 null: false
    t.string   "payment_method",         null: false
    t.datetime "received_on",            null: false
    t.integer  "gateway_transaction_id", null: false
    t.integer  "booking_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "file_name"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "phrases", force: :cascade do |t|
    t.integer  "node_id",      null: false
    t.string   "name",         null: false
    t.string   "junior_field"
    t.string   "text"
    t.string   "prefix"
    t.string   "suffix"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phrases", ["node_id"], name: "index_phrases_on_node_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "description",   null: false
    t.string   "platform",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_url"
    t.string   "preview_photo"
    t.integer  "position"
  end

  create_table "program_notes", force: :cascade do |t|
    t.string   "program_slug"
    t.integer  "school_id",    null: false
    t.text     "text",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "first_name",        null: false
    t.string   "middle_name",       null: false
    t.string   "last_name",         null: false
    t.string   "student_number",    null: false
    t.string   "email_address",     null: false
    t.string   "degree",            null: false
    t.string   "registration_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id",         null: false
    t.datetime "ceremony"
  end

  add_index "registrations", ["school_id"], name: "index_registrations_on_school_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",                                    null: false
    t.string   "code",                                    null: false
    t.string   "parent_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_photo"
    t.string   "grad_program_code"
    t.boolean  "registrations_enabled",   default: false
    t.string   "grad_group_code"
    t.string   "school_day_program_code"
  end

  add_index "schools", ["code"], name: "index_schools_on_code", unique: true, using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "title",                          null: false
    t.string   "preview_photo"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "banner_photo"
    t.string   "contact_emails"
    t.boolean  "book_link",      default: false
    t.boolean  "order_link",     default: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "key",        null: false
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["key"], name: "index_settings_on_key", unique: true, using: :btree

  create_table "sittings", force: :cascade do |t|
    t.string   "name",                               null: false
    t.string   "duration",                           null: false
    t.string   "sitting_fee"
    t.string   "deposit"
    t.integer  "event_type_id",                      null: false
    t.string   "grad_program_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sitting_type",      default: "grad", null: false
    t.integer  "school_id"
    t.string   "grad_group_code"
  end

  create_table "time_trade_appointment_types", force: :cascade do |t|
    t.integer  "time_trade_meta_data_id"
    t.string   "type_id",                 null: false
    t.string   "photo_type"
    t.string   "resource_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "time_trade_appointment_types", ["time_trade_meta_data_id", "photo_type"], name: "index_appointment_types_on_meta_data_and_photo_type", unique: true, using: :btree

  create_table "time_trade_imports", force: :cascade do |t|
    t.string   "file",       null: false
    t.text     "import_log"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_trade_meta_data", force: :cascade do |t|
    t.string   "campaign_id"
    t.string   "appointment_type_group_id"
    t.string   "company_name"
    t.string   "school_code",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "time_trade_meta_data", ["school_id"], name: "index_time_trade_meta_data_on_school_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                       null: false
    t.string   "crypted_password",                            null: false
    t.string   "salt",                                        null: false
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.boolean  "enabled"
    t.string   "role",                      default: "admin", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "time_trade_meta_data", "schools"
end
