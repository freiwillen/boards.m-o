class BoardUpdate < ActiveRecord::Base
  belongs_to :board
  scope :unconfirmed, where(:confirmed => false)
  
  #def board
    
  #end
  
  def self.confirm_all
    self.unconfirmed.each{|update| update.confirm}
  end
  
  def confirm
    board.update_attribute :price, price
    update_states
    update_attribute :confirmed, true
  end
  
  
  def update_states
    1.upto(12) do |i|
      update_state(i) if self["m#{i}"] and !self["m#{i}"].blank?
    end
  end
  
  def update_state i
    state = board.states.find_or_create_by_date date_for_state(i)
    #state = BoardState.find_or_create :date => date_for_state(i), :board_id => board.id
    state.update_attribute :state, BoardState.translate_state(self["m#{i}"].split('|')[0])
  end
  
  def date_for_state i
    d = self["m#{i}"].split('|')[1].gsub(' ','').split(/\.|\ ,/)
    Date.new d[1].to_i, d[0].to_i, 1
  end

end
