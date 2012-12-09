class CreateBoardUpdates < ActiveRecord::Migration
  def change
    create_table :board_updates do |t|
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

      t.timestamps
    end
  end
end
