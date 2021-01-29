class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  before_action :set_locale


  def set_locale
   I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end


  def require_current_user
    # unless current_user.role.include?("administrator") ||
    #   current_user.role.include?("intern")
    #   flash[:error] = "You must be logged in"
    #   redirect_to root_path
    # end
  end
end


  # def set_locale
  #   I18n.locale = params[:locale] if params[:locale].present?
  # end


