class CodeRelation < ActiveRecord::Base
  def self.import(native,foreign)
    unless native.blank? || foreign.blank? || find(:first, :conditions => {:code => native, :foreign_code => foreign})
      create(:code => native, :foreign_code => foreign)
    end
  end
  
  def board
    Board.find_by_code code
  end
end
