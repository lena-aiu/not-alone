class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!

  def require_current_user
    unless current_user.role.include?("administrator") ||
      current_user.role.include?("intern")
      flash[:error] = "You must be logged in"
      redirect_to root_path
    end
  end 
end
