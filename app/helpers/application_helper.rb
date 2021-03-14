module ApplicationHelper

  def is_user_authorized?
      if intern? || admin?
        return 
      else
        flash[:error] = "You are not authorize for this operation."
        redirect_to services_path
      end
  end

  def is_user_authorized_order?
    if intern? || admin?
      return 
    elsif volunteer?
      @customers = current_user.customers
    else
      flash[:error] = "You are not authorize for this operation."
      redirect_to new_user_session_path
    end
  end

end
