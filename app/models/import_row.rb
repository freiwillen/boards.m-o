class ImportRow < ActiveRecord::Base
  belongs_to :import_sheet

  def apply
   #find board by code
   #if not found, find or create point by address
   #attach board to point
   #update statuses
    Board.import import_params #{
  end

  def import_params
    { 
      :board => {
        :code => code,
        :size => size,
        :side => side,
        :construction_type => construction_type,
        :price => price
      },
      :point => {
        :address => address,
        :city => city,
        :district => district
      },
      :dates => dates
    }
  end

  ImportColumn.names.each_key do |method_name|
    define_method method_name do
      instance_variable_get(:"@#{method_name}") || instance_variable_set(:"@#{method_name}", send(:"cell#{import_sheet.send(:"#{method_name}_cell_number")}")) rescue nil
    end
  end

  def dates
    @dates = {}
    import_sheet.date_column_numbers.each_with_index do |date_column_number, i|
      @dates[:"m#{i + 1}"] = [
        read_attribute(:"cell#{date_column_number[1]}"), 
        date_column_number[0].strftime('%m.%Y')
      ].join('|')
    end
    @dates
  end

end
