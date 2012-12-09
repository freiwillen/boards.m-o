class AddIconFieldsToReferencePoint < ActiveRecord::Migration
  def self.up
    #change_table :images do |t|
    #  t.has_attached_file :photo
    #end
    add_column :reference_points, :icon_file_name, :string
    add_column :reference_points, :icon_file_size, :integer
    add_column :reference_points, :icon_content_type, :string
    add_column :reference_points, :icon_updated_at, :datetime
  end

  def self.down
    drop_attached_file :reference_points, :icon
  end
end
