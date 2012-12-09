class CodeRelationsController < InheritedResources::Base
  def import
    fp = "#{Rails.root}/tmp/xl/relations.xls"
    File.open(fp,'w'){|f| f.write params[:relations].read}
    relations = Excel.new(fp)
    relations.sheets.each do |sheet|
      relations.default_sheet = sheet
      2.upto(relations.last_row) do |l|
        CodeRelation.import(relations.cell(l,'A').to_s.gsub(/^\ +|\ +$/,''), relations.cell(l,'B').to_s.gsub(/^\ +|\ +$/,''))
      end
    end
    redirect_to code_relations_path
  end 
end
