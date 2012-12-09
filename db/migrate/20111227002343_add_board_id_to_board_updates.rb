class AddBoardIdToBoardUpdates < ActiveRecord::Migration
  def change
    add_column :board_updates, :board_id, :integer
  end
end
