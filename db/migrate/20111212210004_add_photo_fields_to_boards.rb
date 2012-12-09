class AddPhotoFieldsToBoards < ActiveRecord::Migration
  def self.up
    #change_table :images do |t|
    #  t.has_attached_file :photo
    #end
    add_column :boards, :photo_file_name, :string
    add_column :boards, :photo_file_size, :integer
    add_column :boards, :photo_content_type, :string
    add_column :boards, :photo_updated_at, :datetime
  end

  def self.down
    drop_attached_file :boards, :photo
  end
 
end
