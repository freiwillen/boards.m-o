class OffersController < InheritedResources::Base

  [:create, :update].each do |action|
    define_method action do
      super do |format|
        resource.boards_by_ids = params[:boards]
      end
    end
  end
  
  
  def export
    @offer = Offer.find params[:id]
    date_range = (Date.today..(Date.today+6.month))
    
    workbook = Spreadsheet::Workbook.new()
    worksheet = workbook.create_worksheet()
    #worksheet[0, 0] = "Hello, World!"
    worksheet.row(0).concat(["code", "city/district", "address", "direction", "type","size","price"] + (0...6).to_a.map{|i| (date_range.first+i.month).strftime('%m.%Y')})# +["сторінка"])
    #workbook.write("tmp/offers/offer#{params[:id]}.xls")
    link_format = Spreadsheet::Format.new :color => :blue, :underline => true
    worksheet.column(1).width = 40
    worksheet.column(2).width = 55
    worksheet.column(3).width = 20
    @offer.boards.
    sort{|a,b| a.point.region.name <=> b.point.region.name}.
    sort{|a,b| a.point.city.name <=> b.point.city.name}.
    sort{|a,b| a.code <=> b.code}.
    each_with_index do |board,i|
      point = board.point
      district = point.district
      district =  (district.parent ? district.parent.name+' / ' : '')+district.name
      [Spreadsheet::Link.new('http://billboards.kffa.info'+board_by_code_path(board.code), board.code), district, board.point.address, board.direction, board.construction_type, board.size, board.price, board.states_for_range(date_range).map{|state| state.state}].each_with_index do |cell,j|
        worksheet.row(i+1).push(cell)
        worksheet.row(i+1).set_format(j,link_format) if j == 0
      end
    end
    workbook.write("tmp/offers/offer#{params[:id]}.xls")
    send_data(File.open("tmp/offers/offer#{params[:id]}.xls",'r'){|f|f.read}, :filename => "offer#{params[:id]}.xls")
  end
  
end
