class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user
  
  # 1) check if user is logged in
  def logged_in?
    session[:user_id]
  end

  # 2) get the current logged-in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if logged_in?
  end

  # 3) redirect to '/login' if not authenticated
  def authenticate_user
    redirect_to login_path unless logged_in?
  end
end