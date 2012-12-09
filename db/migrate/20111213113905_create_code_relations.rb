class CreateCodeRelations < ActiveRecord::Migration
  def change
    create_table :code_relations do |t|
		t.string   "code"
		t.string   "foreign_code"

      t.timestamps
    end
  end
end
