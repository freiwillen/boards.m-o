module PointsHelper
  def links_to_edit_boards point
    point.boards.map do |board| 
      link_to(board.code, edit_point_board_path(point.id, board.id))
    end.join(', ')
  end
end
