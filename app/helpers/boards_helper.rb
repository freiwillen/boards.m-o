module BoardsHelper
  def state_select_options
    Board.states.map do |state|
      "<option value='#{state}'>#{state}</option>"
    end.join.html_safe
  end
end
