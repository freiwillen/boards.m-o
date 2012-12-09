require 'spec_helper'

describe ImportSheet do
  it "should have date column numbers" do
    sheet = ImportSheet.new
    sheet.stub_chain(:columns, :where).and_return((1..12).to_a.map{|index| mock_model(ImportColumn, :number => index, :recognized_as => "#{index}.2011")})
    sheet.date_column_numbers.should eq( (1..12).to_a.map{|index| [Date.new(2011, index, 1), index]} )
  end


  ImportColumn.names.keys.each_with_index do |cell_name, index|
    it "should have number of #{cell_name} cell" do
      sheet = ImportSheet.new
      columns = []
      columns.should_receive(:find_by_recognized_as).with(cell_name.to_s).and_return(mock_model(ImportColumn, :number => index))
      sheet.stub(:columns).and_return(columns)
      sheet.send("#{cell_name}_cell_number").should eq(index)
    end
  end
end
