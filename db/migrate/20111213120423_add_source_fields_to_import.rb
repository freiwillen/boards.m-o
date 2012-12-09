class AddSourceFieldsToImport < ActiveRecord::Migration
  def self.up
    add_column :imports, :source_file_name, :string
    add_column :imports, :source_file_size, :integer
    add_column :imports, :source_content_type, :string
    add_column :imports, :source_updated_at, :datetime
  end

  def self.down
    drop_attached_file :imports, :source
  end
  
end
