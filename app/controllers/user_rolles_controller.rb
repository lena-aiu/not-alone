class UserRollesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

    before_action :set_user_rolle, only: [:edit, :update, :destroy, :show]
    before_action :authenticate_user!

    helper_method :admin?
    helper_method :intern?

    def index
        if current_user.role&.include?("administrator") || current_user.role&.include?("intern")
          @user_rolles = User.all
        else
          flash.notice = "You are not authorized for that operation."
          redirect_to home_index_path
        end
      end

    def show
      if current_user.role&.include?("administrator") || current_user.role&.include?("intern")
      render :show
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
  end
  
  def edit

    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator")
      render :edit
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
  end

  def destroy
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator")
      @user_rolle.destroy
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    @user_rolle.destroy
    respond_to do |format|
      format.html { redirect_to user_rolles_path, notice: 'The user record was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  def update
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator")
      role=""
      if params["volunteer"] == "1"
        role = "volunteer"
      end
      if params["intern"] == "1" 
        if role == ""
          role = "intern"
        else 
          role += ",intern"
        end
      end
      if params["administrator"] == "1" 
        if role == ""
          role = "administrator"
        else 
          role += ",administrator"
        end
      end

      @user_rolle.update(role: role)
      flash.notice = "The user record was updated successfully."
      redirect_to user_rolle_path(id: @user_rolle.id)
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
  end
  private
  def set_user_rolle
    @user_rolle = User.find(params[:id])
  end
  def catch_not_found(e)
    Rails.logger.debug("We had a not found exception.")
    flash.alert = e.to_s
    redirect_to user_rolles_path
  end
end

