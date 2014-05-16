#encoding: utf-8
#require 'roo'
class ImportSheet < ActiveRecord::Base
  attr_accessor :sheet
  belongs_to :import
  has_many :columns, :class_name => 'ImportColumn', :dependent => :destroy
  has_many :rows, :class_name => 'ImportRow', :dependent => :destroy, :order => :number

  before_create :read_columns, :read_rows

  
  def read_columns
    ImportColumn.letters.each_with_index do |letter,i|
      columns.build :name => sheet.cell(1,letter).to_s, :number => i + 1
    end
  end
  
  def read_rows
    2.upto(sheet.last_row) do |i|
      row = {:number => i-1}
      ImportColumn.letters.each_with_index do |letter,j|
        row[:"cell#{j+1}"] = sheet.cell(i,letter).to_s.gsub('вул.','').gsub('Вул.','').gsub('Eл.','').gsub('ул.','').strip;
      end
      rows.build row
    end
  end

  def apply
    rows.each { |row| row.apply }
  end

  ImportColumn.names.each_key do |cell_name|
    define_method "#{cell_name}_cell_number" do
      instance_variable_get("@#{cell_name}_cell_number".to_sym) || instance_variable_set("@#{cell_name}_cell_number".to_sym, columns.find_by_recognized_as(cell_name.to_s).number) rescue nil
    end
  end

  def date_column_numbers
    columns.where('recognized_as = ?', 'date').map do |column|
      [Date.strptime(column.name, '%Y-%m-%d'), column.number]
    end
  end
end
