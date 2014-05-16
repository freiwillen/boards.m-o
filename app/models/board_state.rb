#encoding: utf-8
class BoardState < ActiveRecord::Base
  belongs_to :board
  
  def self.translate_state(p)
    if %w{занято 1 х x бронь продано}.include? p
      'бронь'
    elsif (['']+%w{0 вільно пусто}).include? p
      ''
    else
      'резерв'
    end
  end
  
end
