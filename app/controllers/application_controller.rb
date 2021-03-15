class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
   I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  def admin?
    if current_user.nil?
      return false
    end
    if current_user.role.nil?
      return false
    end
    current_user.role.include?("administrator")
  end

  def intern?
    if current_user.nil?
      return false
    end
    if current_user.role.nil?
      return false
    end
    current_user.role.include?("intern")
  end

  def volunteer?
    if current_user.nil?
      return false
    end
    if current_user.role.nil?
      return false
    end
    current_user.role.include?("volunteer")
  end
end
