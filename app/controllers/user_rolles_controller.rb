class UserRollesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

    before_action :set_user_rolle, only: [:edit, :update, :destroy, :show]
    before_action :authenticate_user!

    helper_method :admin?
    helper_method :intern?

    def index
        if current_user.role.nil? || current_user.role.include?("volunteer")
          flash.notice = "You are not authorized for that operation."
          redirect_to home_index_path
        elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
          @user_rolles = User.all
        else
          flash.notice = "You are not authorized for that operation."
          redirect_to home_index_path
        end
      end

    def show
    if current_user.role.nil? || current_user.role.include?("volunteer")
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
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
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
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
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
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
  private
  def set_user_rolle
    @user_rolle = User.find(params[:id])
  end
end

