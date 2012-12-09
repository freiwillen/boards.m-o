class ImportColumn < ActiveRecord::Base

  belongs_to :import_sheet

  before_create :before_create
  def self.letters
    %w{A B C D E F G H I J K L M N O P Q R S T U}
  end
  
  def self.names
    @names ||= {
      :city => ['Місто','місто'],
      :district => ['Район','район'],
      :address => ['Адреса','адреса'],
      :code => ['Код','код'],
      :direction => ['Напрям','напрям'],
      :construction_type => ['Тип','тип'],
      :size => ['Розмір','розмір'],
      :price => ['Ціна','ціна'],
      :side => ['Сторона','сторона'],
    }
  end

  def self.recognized
    where(:recognized_as => recognized_columns_names)
  end

  def self.recognized_columns_names
    @recognized_column_names ||= ImportColumn.names.keys.push(:date).map{ |key| key.to_s }
  end
  
  def self.get_name p
    names.each_pair do |key, values|
      return key if values.include? p
    end
    nil
  end
  
  def before_create
    self.recognized_as = recognize ? recognize : 'нерозпізнано'
  end
  
  def recognize
    @recognize = recognize_name || recognize_date
    
  end
  
  def recognize_name
    ImportColumn.get_name name
  end
  
  def recognize_date
    'date' if name.match(/^\d{2,4}-\d{1,2}-\d{2,4}$/) || name.match(/^\d{1,2}\.\d{2,4}$/)
  end
  
end
