class ImportsController < InheritedResources::Base
  def create
    super do |response|
      response.html { redirect_to resource_path }
    end
  end

  def apply
    Import.find(params[:id]).apply
    redirect_to imports_path
  end
end
