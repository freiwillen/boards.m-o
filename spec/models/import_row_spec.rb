require 'spec_helper'

describe ImportRow do
  before :each do
    @import_sheet = mock_model(ImportSheet)
    @import_row = ImportRow.new
    @import_row.stub(:import_sheet).and_return(@import_sheet)
  end

  describe 'cell reader' do 
    [:code, :address, :city, :district, :size, :side, :construction_type, :price].each_with_index do |reader_name, index|
      it "#{reader_name} should read data from approriate cell" do
        @import_sheet.stub(:"#{reader_name}_cell_number").and_return(index + 1)
        @import_row.should_receive(:"cell#{index + 1}").and_return(index * 10)
        @import_row.send(reader_name).should eq(index * 10)
      end
    end

  end

  describe "dates reader" do
    before :each do
      @today = Date.today

      (1..12).to_a.each do |index|
        @import_row.should_receive(:read_attribute).with(:"cell#{index}").and_return(index * 10)
      end

    end

    it "should return array of date to cell number accordings" do
      @import_sheet.stub(:date_column_numbers).and_return(
        (1..12).to_a.map{ |index| [@today + index.months, index] }
      )

      @import_row.dates.should eq(
        :m1 => "10|#{(@today + 1.month).strftime('%m.%Y')}",
        :m2 => "20|#{(@today + 2.month).strftime('%m.%Y')}",
        :m3 => "30|#{(@today + 3.month).strftime('%m.%Y')}",
        :m4 => "40|#{(@today + 4.month).strftime('%m.%Y')}",
        :m5 => "50|#{(@today + 5.month).strftime('%m.%Y')}",
        :m6 => "60|#{(@today + 6.month).strftime('%m.%Y')}",
        :m7 => "70|#{(@today + 7.month).strftime('%m.%Y')}",
        :m8 => "80|#{(@today + 8.month).strftime('%m.%Y')}",
        :m9 => "90|#{(@today + 9.month).strftime('%m.%Y')}",
        :m10 => "100|#{(@today + 10.month).strftime('%m.%Y')}",
        :m11 => "110|#{(@today + 11.month).strftime('%m.%Y')}",
        :m12 => "120|#{(@today + 12.month).strftime('%m.%Y')}"
      )

    end

  end

end
