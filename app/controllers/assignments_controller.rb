class AssignmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def show
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      render :show
    elsif current_user.role.include?("volunteer")
      if current_user.customers.include? @assignment.customer
        render :show
      else
        flash.notice = "You are not authorized for that operation."
        redirect_to home_index_path
      end
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
    @customer = Customer.find params[:customer_id]
    @assignment = @customer.assignments.new
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to customers_path
    end
  end

  def edit
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
    @assignment = Assignment.find(params[:id])
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
      @customer = Customer.find params[:customer_id]
      @assignment = @customer.assignments.new(assignment_params)
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    @customer = Customer.find params[:customer_id]
    @assignment = @customer.assignments.new(assignment_params)
    if @assignment.save
      flash.notice = "The assignment record was created successfully."
      redirect_to @assignment
    else
      flash.now.alert = @assignment.errors.full_messages.to_sentence
      render :edit
    end
  end

  def update
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @assignment.update(assignment_params)
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    if @assignment.update(assignment_params)
      flash.notice = "The assignment record was updated successfully."
      redirect_to @assignment
    else
      flash.now.alert = @assignment.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @customer = @assignment.customer
      @assignment.destroy
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    @customer = @assignment.customer
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to @customer, notice: 'The assignment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def set_assignment
    if params[:customer_id].nil?
      @customer=nil
    else
      @customer=Customer.find(params[:customer_id])
    end
      @assignment = Assignment.find(params[:id])
  end

  def assignment_params
    params.require(:assignment).permit(:customer_id, :user_id, :status)
  end

  def catch_not_found(e)
    Rails.logger.debug("We had a not found exception.")
    flash.alert = e.to_s
    if !@customer.nil?
      redirect_to @customer
    else
      redirect_to customers_path
    end
  end
end
