#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user, :last_point
  before_filter :set_locale
  before_filter :require_user, :except => [:stub, :home, :team, :contacts, :clients]
  before_filter :require_admin, :except => [:stub, :index, :home, :team, :contacts, :clients]

  def home
  end

  def index
    #raise Region.getall.first.cities.inspect
    @update_date = ''
    @update_time = ''
    @boards = []#Board.find(:all)
    @districts = Region.find(:all)
    @cities = City.find(:all)
    @rps = ReferencePoint.all
    #raise @rps.select{|p| p.address.blank? }.size.inspect
    @construction_types = []
    @cols = []
    @sizes = []
    if @boards.any?
      @update_time = @boards.first.created_at.strftime('%H:%M')
      @update_date = @boards.first.date.strftime('%d.%m')
      @construction_types = @boards.map{|b| b.construction_type}.uniq
      @sizes = @boards.map{|b| b.size}.uniq.compact.sort
      1.upto(12) do |i|
        t = @boards.first.read_attribute("m#{i}".to_sym)
        @cols <<  t.split('|')[1] if t and t.include? '|'
      end
      @cols = @cols[0..5]
    end
  end

  def login
    @user = User.new
    if @user.login(params[:pass])
      session[:user] = @user
      #raise session[:user].logged_in.inspect
      flash[:notice] = 'You are logged in'
    else
      flash[:warning] = 'Failed to log in'
    end

    redirect_to '/'
  end

  def logout
    session[:user] = nil
    redirect_to '/'
  end
  
protected

  def last_point
    session[:last_point] ||= ''
    session[:last_point]
  end

  #def current_user
    #session[:user]
  #  User.new
  #end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to stub_path
      return false
    end
  end
  def require_admin
    unless current_user.admin?
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to stub_path
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_path
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.url
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def set_locale
   redirect_to '/ua' if params[:locale].blank?
   I18n.locale = params[:locale]
  end

  def default_url_options options={}
    options.merge :locale => I18n.locale
  end



end
