class AssignmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @customer = Customer.find params[:customer_id]
    @assignments = @customer.assignments 
  end

  def show
  end

  def new
    @customer = Customer.find params[:customer_id]
    @assignment = @customer.assignments.new
  end

  def edit
  end

  def create
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
    if @assignment.update(assignment_params)
      flash.notice = "The assignment record was updated successfully."
      redirect_to assignment_path(@assignment)
    else
      flash.now.alert = @assignment.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @customer_id = @assignment.customer_id
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to customer_assignments_path(customer_id: @customer_id), notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_assignment
    @customer = nil #Customer.find params[:customer_id]
    @assignment = Assignment.find(params[:id])
  end

  def assignment_params
    params.require(:assignment).permit(:customer_id, :user_id, :status)
  end

  def catch_not_found(e)
    Rails.logger.debug("We had a not found exception.")
    flash.alert = e.to_s
    if @customer.nil?
      redirect_to customers_path 
    else
      redirect_to @customer
    end
  end
end
