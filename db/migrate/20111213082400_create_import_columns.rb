class CreateImportColumns < ActiveRecord::Migration
  def change
    create_table :import_columns do |t|
		t.integer  "import_sheet_id"
		t.integer  "number"
		t.string   "name"
		t.string   "recognized_as"
        t.timestamps
    end
  end
end
