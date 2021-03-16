module ApplicationHelper

  def is_user_authorized?
      if intern? || admin?
        return 
      else
        flash[:error] = "You are not authorized for this operation."
        redirect_to services_path
      end
  end

  def is_user_authorized_order
    if intern? || admin?
      return
    else
      flash[:error] = "You are not authorized for this operation."
      redirect_to home_index_path
    end
  end

  def is_user_authorized_category
    if intern? || admin?
      return
    else
      flash[:error] = "You are not authorized for this operation."
      redirect_to home_index_path
    end
  end

end
