module ApplicationHelper

    def is_user_authorized?
        if intern? || admin?
          return
        else
          flash[:error] = "You are not authorize for this operation."
          redirect_to services_path
        end
    end

    # def active_tab(path)
    #   request.path.match(/^#{path}/) ? { :class => 'active' } : {}
    # end



end
