class PointsController < InheritedResources::Base
  skip_before_filter :require_admin, :only => :autocomplete
  [:create, :update].each do |action|
    define_method action do
      super() do |response|
        response.html { redirect_to edit_resource_path }
      end
    end
  end

  def destroy
    super do |response|
      response.html { redirect_to points_path }
    end
  end

  def autocomplete
    resp = if params[:q].present? && params[:q].length >= 4
      @points = Point.find(:all, :conditions => ['address like ?', "%#{params[:q]}%"])
      @points.select{|point| point.reference_point.city?}.map do |point|
        "#{point.reference_point.name}, #{point.address}|#{point.reference_point.name}|#{point.reference_point.parent.name}|#{point.coords}".html_safe
      end.join("\n")
    else
      ''
    end
    render :inline => resp, :layout => false
  end
  

end
