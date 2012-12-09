class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
		t.boolean  "applied",    :default => false
		t.boolean  "foreign",    :default => false

      t.timestamps
    end
  end
end
