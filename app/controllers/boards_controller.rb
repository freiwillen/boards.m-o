class BoardsController < InheritedResources::Base
  skip_before_filter :require_user, :only => :by_code
  skip_before_filter :require_admin, :only => :by_code
  belongs_to :point

  [:create, :update, :destroy].each do |action|
    define_method action do
      super() do |response|
        response.html { redirect_to edit_point_path(parent) }
      end
    end
  end

  def by_code
    @board = Board.find_by_code params[:code]
    render 'show'
  end

end
