class Offer < ActiveRecord::Base
  has_and_belongs_to_many :boards
  def boards_by_ids=(p)
    self.boards.clear
    p.each_key do |board_id| 
      board = Board.find(board_id)
      #raise board.nearest_states.select{|state| state.blank?}.inspect
      #raise board.nearest_states.map(&:state).inspect
      self.boards << board unless board.nearest_states.select{|state| state.blank?}.size < board.nearest_states.size
      
    end
  end
end
