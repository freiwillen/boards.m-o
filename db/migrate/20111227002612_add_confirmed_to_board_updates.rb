class AddConfirmedToBoardUpdates < ActiveRecord::Migration
  def change
    add_column :board_updates, :confirmed, :boolean, :default => false
  end
end
