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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111227002612) do

  create_table "board_states", :force => true do |t|
    t.string   "state"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id"
  end

  create_table "board_updates", :force => true do |t|
    t.string   "city"
    t.string   "code"
    t.string   "size"
    t.string   "address"
    t.string   "construction_type"
    t.string   "side"
    t.string   "price"
    t.string   "m1"
    t.string   "m2"
    t.string   "m3"
    t.string   "m4"
    t.string   "m5"
    t.string   "m6"
    t.string   "m7"
    t.string   "m8"
    t.string   "m9"
    t.string   "m10"
    t.string   "m11"
    t.string   "m12"
    t.string   "district"
    t.date     "date"
    t.integer  "point_id"
    t.string   "direction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id"
    t.boolean  "confirmed"
  end

  create_table "boards", :force => true do |t|
    t.string   "city"
    t.string   "code"
    t.string   "size"
    t.string   "address"
    t.string   "construction_type"
    t.string   "side"
    t.string   "price"
    t.string   "m1"
    t.string   "m2"
    t.string   "m3"
    t.string   "m4"
    t.string   "m5"
    t.string   "m6"
    t.string   "m7"
    t.string   "m8"
    t.string   "m9"
    t.string   "m10"
    t.string   "m11"
    t.string   "m12"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "district"
    t.date     "date"
    t.integer  "point_id"
    t.string   "direction"
    t.string   "photo_file_name"
    t.integer  "photo_file_size"
    t.string   "photo_content_type"
    t.datetime "photo_updated_at"
  end

  create_table "boards_offers", :id => false, :force => true do |t|
    t.integer "board_id"
    t.integer "offer_id"
  end

  add_index "boards_offers", ["board_id"], :name => "board_id"
  add_index "boards_offers", ["offer_id"], :name => "offer_id"

  create_table "code_relations", :force => true do |t|
    t.string   "code"
    t.string   "foreign_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "import_columns", :force => true do |t|
    t.integer  "import_sheet_id"
    t.integer  "number"
    t.string   "name"
    t.string   "recognized_as"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "import_rows", :force => true do |t|
    t.integer  "import_sheet_id"
    t.string   "cell1"
    t.string   "cell2"
    t.string   "cell3"
    t.string   "cell4"
    t.string   "cell5"
    t.string   "cell6"
    t.string   "cell7"
    t.string   "cell8"
    t.string   "cell9"
    t.string   "cell10"
    t.string   "cell11"
    t.string   "cell12"
    t.string   "cell13"
    t.string   "cell14"
    t.string   "cell15"
    t.string   "cell16"
    t.string   "cell17"
    t.string   "cell18"
    t.string   "cell19"
    t.string   "cell20"
    t.string   "cell21"
    t.string   "cell22"
    t.string   "cell23"
    t.string   "cell24"
    t.string   "cell25"
    t.string   "cell26"
    t.string   "cell27"
    t.string   "cell28"
    t.string   "cell29"
    t.string   "cell30"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "import_sheets", :force => true do |t|
    t.integer  "import_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imports", :force => true do |t|
    t.boolean  "applied",             :default => false
    t.boolean  "foreign",             :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source_file_name"
    t.integer  "source_file_size"
    t.string   "source_content_type"
    t.datetime "source_updated_at"
  end

  create_table "offers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date",       :null => false
  end

  create_table "points", :force => true do |t|
    t.string   "address"
    t.string   "coords"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reference_point_id"
    t.float    "coord_x",            :default => 0.0, :null => false
    t.float    "coord_y",            :default => 0.0, :null => false
  end

  create_table "reference_points", :force => true do |t|
    t.string   "name"
    t.string   "coords"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "city",              :default => false
    t.boolean  "district",          :default => false
    t.integer  "parent_id"
    t.string   "address"
    t.string   "type"
    t.string   "name_ukr"
    t.float    "coord_x",           :default => 0.0,   :null => false
    t.float    "coord_y",           :default => 0.0,   :null => false
    t.string   "icon_file_name"
    t.integer  "icon_file_size"
    t.string   "icon_content_type"
    t.datetime "icon_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                       :null => false
    t.string   "role",                :default => "customer"
    t.string   "email",                                       :null => false
    t.string   "crypted_password",                            :null => false
    t.string   "password_salt",                               :null => false
    t.string   "persistence_token",                           :null => false
    t.string   "single_access_token",                         :null => false
    t.string   "perishable_token",                            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
