class CreateImportSheets < ActiveRecord::Migration
  def change
    create_table :import_sheets do |t|
		t.integer  "import_id"
    
		t.string   "name"
		t.timestamps
    end
  end
end
