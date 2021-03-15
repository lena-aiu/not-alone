class CategoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  include ApplicationHelper
  
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.role.nil? || current_user.role.include?("volunteer")
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @categories = Category.all
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

  def new
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @category = Category.new
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

  def create
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @category = Category.new(category_params) 
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    @category = Category.new(category_params) 
    if @category.save
      flash.notice = "The customer record was created successfully."
      redirect_to @category
    else
      flash.now.alert = @category.errors.full_messages.to_sentence
      render :new  
    end
  end

  def update
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @category.update(category_params)
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    if @category.update(category_params)
      flash.notice = "The customer record was updated successfully."
      redirect_to @category
    else
      flash.now.alert = @category.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @category.destroy
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_path, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to categories_path
    end
end
