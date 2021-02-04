class CategoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  
  helper_method :admin?
  helper_method :intern?

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
    #byebug
  end

  def edit
  end

  def create
    @category = Category.new(category_params) 
    if @category.save
      flash.notice = "The category record was created successfully."
      redirect_to @category #check
    else
      flash.now.alert = @category.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash.notice = "The category record was updated successfully."
      redirect_to @category
    else
      flash.now.alert = @category.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to category_url, notice: 'Category was successfully destroyed.' }
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
end
