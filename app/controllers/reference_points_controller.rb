class ReferencePointsController < InheritedResources::Base
  skip_before_filter :require_admin, :only => :filter_options
  [:create, :update].each do |action|
    define_method action do
      super do |response|
        response.html { redirect_to collection_path }
      end
    end
  end

  def filter_options
    @points = City.find(params[:id], :include => :points).points
    respond_to do |format|
      format.js {render 'filter_options', :layout => false}
    end
  end

end
