#encoding: utf-8
class Board < ActiveRecord::Base
  belongs_to :point#, :foreign_key => 'address'
  has_many :states, :class_name => 'BoardState', :order => 'date'
  has_many :updates, :class_name => 'BoardUpdate'
  has_and_belongs_to_many :offers

  has_attached_file :photo
  
  def self.sizes
    %w{6x3 3x4 3x6 3х5 3х7 4x3 4x4 1,2х1,8 інший}
  end
  
  def self.construction_types
    %w{щит призма беклайт сіті-лайт}
  end
  
  def self.sides
    %w{А Б В}
  end
  
  def self.states
    ['','бронь','резерв']
  end
  
  def set_states(p)
    p.each_pair do |date,value|
      date = Date.new(date.split('-')[1].to_i, date.split('-')[0].to_i, 1)
      state = self.states.find :first, :conditions => {:date => date}
      state ||= BoardState.create :board_id => self.id, :date => date
      state.update_attribute :state, value
    end
  end
  
  def states_for_range(range)
    states = self.states.find_all{|state| state.date >= Date.new(range.first.year, range.first.month, 1) and state.date <= Date.new(range.last.year, range.last.month, 1)}
  end
  
  def nearest_states(c=6)
    states = self.states.find_all{|state| state.date >= Date.new(Date.today.year, Date.today.month, 1)}[0...6]
    if states.any? && states.size < c 
      states.last.date.upto(states.last.date+(6-states.size+1).months) do |date|
        s = BoardState.create :date => date, :state => '', :board_id => self.id
        states << s
      end
    end
    states
  end
  
  def self.import(h)
    if h
      #if board already exists, we should only update states
      code = h[:board][:code]
      
      if Board.where(:code => code).any?
        code
      elsif CodeRelation.where(:foreign_code => code).any?
        CodeRelation.find_by_foreign_code(code).code
      else
        code
      end

      if Board.where(:code => code).any?
        board = Board.find_by_code code
        board.updates.unconfirmed.delete_all
        board.updates.create h[:dates].merge(:price => h[:board][:price])
      else
        board = Board.create :code => code
        board.create_point h[:point]
        board.updates.unconfirmed.delete_all
        board.updates.create h[:board].merge(h[:dates]).merge(:code => code)
      end
      board.updates.unconfirmed.confirm_all
    end
  end

  def self.find_or_initialize_by_code code
    board = find_by_code code
    if board.nil?
      board = find_by_code CodeRelation.find_by_foreign_code(code)
    end
    board.nil? ? Board.create(:code => code, :side =>h[:general][:side], :size => h[:general][:size], :construction_type => h[:general][:construction_type]) : board
  end

  def prepare_update_params p
    result = {}
    if new_record?
      1.upto(12) { |i| result[:"m#{i}"] = p[:"m#{i}"] }
    else
      result = p
    end
    result
  end

  def create_point p
    reference_point = ReferencePoint.find_by_name(p[:city]) || ReferencePoint.find_by_name(p[:district])
    Point.create(:address => p[:address], :reference_point => reference_point).boards << self
  end
  
  def coords
    self.point.coords if self.point
  end
  
  def price
    read_attribute(:price).to_s.gsub('.0','')
  end
  
  def address
    self.point.address
  end
  
  (1..12).to_a.each do |i|
    define_method :"m#{i}" do
      read_attribute(:"m#{i}").to_s.split('|')[0]
    end
  end
  
#  def photo=(p)
#    unless p.blank? or self.code == nil
#      path = c_dir+"#{self.code}.jpg"
#      FileUtils.rm path if File.exist? path
#      File.open(path,'wb'){|f|f.write(p.read)}
#    end
#  end
  
  def url
    if self.id and File.exist?(c_dir+"#{self.code}.jpg")
      "/#{ph_dir}#{self.code}.jpg"
    else
      false
    end
  end
=begin  
  def before_save
    self.description = normalize_text(self.description)
    self.title = normalize_text(self.title)
  end
=end  
  def before_destroy
    path = c_dir+"#{self.code}.jpg"
    FileUtils.rm path if File.exist? path
  end

  def has_old_photo?
    File.exist?(old_photo_path)
  end

  def old_photo_path
    c_dir+"#{self.code}.jpg"
  end
	
	
private	
	
  def c_dir
    "#{Rails.root}/public/old_photos/"
  end
  
  def ph_dir
    c_dir.gsub('public/','')
  end
  
end
