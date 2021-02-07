module ApplicationHelper

    def is_user_authorized?
        if intern? || admin?
          return 
        else
          flash[:error] = "You are not authorize for this operation."
          redirect_to services_path
        end
    end

end
