class Initialize < ActiveRecord::Migration
  def up

#=begin
    create_table "board_states", :force => true do |t|
      t.string   "state"
      t.date     "date"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "board_id"
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
    end

    create_table "boards_offers", :id => false, :force => true do |t|
      t.integer "board_id"
      t.integer "offer_id"
    end

    add_index "boards_offers", ["board_id"], :name => "board_id"
    add_index "boards_offers", ["offer_id"], :name => "offer_id"

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
      t.boolean  "city",       :default => false
      t.boolean  "district",   :default => false
      t.integer  "parent_id"
      t.string   "address"
      t.string   "type"
      t.string   "name_ukr"
      t.float    "coord_x",    :default => 0.0,   :null => false
      t.float    "coord_y",    :default => 0.0,   :null => false
    end
#=end    
  end

  def down
  end
end
