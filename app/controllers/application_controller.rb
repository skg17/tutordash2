class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # This runs before every action in every controller
  before_action :require_user

  # Makes these methods available to views (ERB files)
  helper_method :current_user, :logged_in?

  private

  # Finds the user object based on the ID stored in the session cookie
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Checks if a user is logged in
  def logged_in?
    !!current_user
  end

  # Requires authentication to access protected pages
  def require_user
    unless logged_in?
      flash[:alert] = "You must be logged in to access that page."
      redirect_to login_path
    end
  end
end
