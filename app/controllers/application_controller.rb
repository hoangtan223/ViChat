class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
  	return @current_user if @current_user
  	if session[:user_id]
  		@current_user = User.find session[:user_id]
  	end
  end

  def logged_in?
  	if session[:user_id]
  		true
  	else
  		false
  	end
  end

  def require_login
  	unless logged_in?
  		flash[:notice] = "You must sign in to see this page!"
  		redirect_to login_path
  	end
  end

  def skip_if_logged_in
  	if logged_in?
  		redirect_to users_path
  	end
  end
end
