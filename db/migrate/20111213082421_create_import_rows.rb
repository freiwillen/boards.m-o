class CreateImportRows < ActiveRecord::Migration
  def change
    create_table :import_rows do |t|
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
      t.timestamps
    end
  end
end
