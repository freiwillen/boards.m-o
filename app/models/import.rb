require 'roo'
class Import < ActiveRecord::Base
  has_many :sheets, :class_name => 'ImportSheet', :dependent => :destroy
  has_attached_file :source
  after_create :read_source

    
  def read_source
    #File.open(source.path,'w'){|f| f.write p.read}
    shfile = Excel.new(source.path)
    shfile.sheets.each do |sheet|
      shfile.default_sheet = sheet
      sheets.create :sheet => shfile, :name => sheet
    end
  end

  def apply
    sheets.each { |sheet| sheet.apply }
    update_attribute :applied, true
  end
end
