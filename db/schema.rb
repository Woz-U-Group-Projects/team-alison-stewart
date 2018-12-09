# encoding: UTF-8
    
  CREATE TABLE  CUSTOMER (
      ID text,
      ADDR_1 text,
      ADDR_2 text,
      ADDR_3 text,
      CITY text,
      STATE text,
      ZIPCODE text,
      COUNTRY text,
      CONTACT_FIRST_NAME text,
      CONTACT_LAST_NAME text,
      CONTACT_PHONE text,
      CONTACT_FAX text,
      CONTACT_MOBILE text,
      CONTACT_EMAIL text,
      NAME text,
      DISCOUNT_CODE text,
      FREE_ON_BOARD text
  );
    
  CREATE TABLE  EMPLOYEES (
      Frist_Name text NOT NULL,
      Last_Name text NOT NULL,
      Title text,
      Employee_Code text,
      Telephone_Number text,
      Extension text,
      Cellphone_Number text,
      Email_Address text NOT NULL,
      Position integer NOT NULL,
      Description text,
      created_at date,
      updated_at date
  );

  CREATE TABLE EVENT_TYPES (
    HIGHRISE_FIELD TEXT,
    CODE TEXT,
    NAME TEXT,
    PROGRAM_SLUG TEXT,
    POSITION INTEGER,
    CREATED_AT DATE,
    UPDATED_AT DATE
  );
    
  CREATE TABLE EVENTS (
    DATE TEXT,
    SCHOOL_ID INTEGER NOT NULL,
    EVENT_TYPE_ID INTEGER NOT NULL,
    CREATED_AT DATE,
    UPDATED_AT DATE
  );
    
CREATE INDEX INDEX_EVENTS_ON_EVENT_TYPE_ID ON EVENTS (EVENT_TYPE_ID) ;
CREATE INDEX INDEX_EVENTS_ON_SCHOOL_ID ON EVENTS (SCHOOL_ID);
CREATE INDEX INDEX_EVENTS_ON_SCHOOL_ID_AND_EVENT ON EVENTS(SCHOOL_ID, EVENT_TYPE_ID);
    
  CREATE TABLE IMPORTANT_DATE_TYPE_PROGRAMS(
    IMPORTANT_DATE_TYPE_ID INTEGER NOT NULL,
    PROGRAM_SLUG TEXT NOT NULL,
    CREATED_AT DATE,
    UPDATED_AT DATE
  );
    
  CREATE TABLE IMPORTANT_DATE_TYPES (
    HIGHRISE_FIELD TEXT NOT NULL,
    CODE TEXT NOT NULL,
    NAME TEXT,
    DYNAMIC_NAME boolean,
    POSITION INTEGER,
    CREATED_AT DATE,
    UPDATED_AT DATE
  );
    
  CREATE TABLE IMPORTANT_DATES (
    SCHOOL_ID INTEGER NOT NULL,
    IMPORTANT_DATE_TYPE_ID INTEGER NOT NULL,
    NAME TEXT NOT NULL,
    VALUE TEXT NOT NULL,
    CREATED_AT DATE,
    UPDATED_AT DATE
  );
    
  CREATE TABLE JOB_POSTINGS (
    NAME TEXT NOT NULL,
    TITLE TEXT,
    JOB_TYPE_ID INTEGER,
    RESPONSIBILITIES TEXT,
    REQUIRMENTS TEXT,
    EXPIRY_DATE DATE,
    CREATED_AT DATE,
    UPDATED_AT DATE,
    POSITION INTEGER
  );
    
  CREATE TABLE JOB_TYPES (
    NAME TEXT NOT NULL,
    CREATED_AT DATE,
    UPDATED_AT DATE,
    POSITION INTEGER
  );

  CREATE INDEX INDEX_JOB_TYPE_ON_NAME ON JOB_TYPES (NAME);  
  
  CREATE TABLE LOOK_BOOKS (
    CREATED_AT DATE,
    UPDATED_AT DATE,
    SERVICE_ID INTEGER NOT NULL,
    TITLE TEXT,
    PROGRAM_SLUG TEXT
  );

  CREATE TABLE NODES (
    TYPE TEXT NOT NULL,
    OWNER_ID INTEGER NOT NULL,
    OWNER_TYPE TEXT NOT NULL,
    X INTEGER NOT NULL,
    Y INTEGER NOT NULL,
    WIDTH INTEGER NOT NULL,
    HEIGHT INTEGER NOT NULL,
    FONT_FAMILY TEXT,
    POINT_SIZE INTEGER,
    NODE_PHOTO TEXT,
    CROP_X INTEGER,
    CROP_y INTEGER,
    CROP_WIDTH INTEGER,
    CROP_HEIGHT INTEGER,
    CREATED_AT TIMESTAMP,
    UPDATED_AT TIMESTAMP,
    NAME TEXT,
    COLOR TEXT DEFAULT '#000000',
    JUNIOR_FIELD TEXT,
    POSITION INTEGER,
    ALIGNMENT TEXT,
    MASK TEXT,
    UPPERCASE BOOLEAN DEFAULT false
  );

  CREATE TABLE PHOTOS (
    FILE_NAME TEXT,
    OWNER_ID INTEGER,
    OWNER_TYPE TEXT,
    DESCRIPTION TEXT,
    POSITION INTEGER,
    CREATED_AT TIMESTAMP,
    UPDATED_AT TIMESTAMP,
    TITLE TEXT
  );

    
  CREATE TABLE PHRASES (
    NODE_ID INTEGER NOT NULL,
    NAME TEXT NOT NULL,
    JUNIOR_FIELD TEXT,
    TEXT TEXT,
    PREFIX TEXT,
    SUFFIX TEXT,
    POSITION INTEGER,
    CREATED_AT TIMESTAMP,
    UPDATED_AT TIMESTAMP
  );

  CREATE INDEX INDEX_PHRASES_ON_NODE_ID ON PHRASES (NODE_ID);     

  CREATE TABLE PRODUCTS (
    NAME TEXT NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    PLATFORM TEXT NOT NULL,
    CREATED_AT TIMESTAMP,
    UPDATED_AT TIMESTAMP,
    VIDEO_URL TEXT,
    PREVIEW_PHOTO TEXT,
    POSITION INTEGER
  );

  CREATE TABLE PROGRAM_NOTES (
    PROGRAM_SLUG TEXT,
    SCHOOL_ID INTEGER NOT NULL,
    TEXT TEXT NOT NULL,
    CREATED_AT TIMESTAMP,
    UPDATED_AT TIMESTAMP
  );

  CREATE TABLE SCHOOLS (
    NAME TEXT NOT NULL,
    CODE TEXT NOT NULL,
    PARENT_CODE TEXT,
    CREATED_AT TIMESTAMP,
    UPDATED_AT TIMESTAMP,
    LOGO_PHOTO TEXT,
    GRAD_PROGRAM_CODE TEXT,
    REGISTRATIONS_ENABLED BOOLEAN DEFAULT FALSE,
    GRAD_GROUP_CODE TEXT,
    SCHOOL_DAY_PROGRAM_CODE TEXT
  );

  CREATE UNIQUE INDEX INDEX_SCHOOLS_ON_CODE ON SCHOOLS (CODE);

  CREATE TABLE SETTINGS (
    KEY TEXT NOT NULL,
    VALUE TEXT,
    CREATED_AT TIMESTAMP,
    UPDATED_AT TIMESTAMP
  );

  CREATE UNIQUE INDEX INDEX_SETTINGS_ON_KEY ON SETTINGS (KEY);


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
  