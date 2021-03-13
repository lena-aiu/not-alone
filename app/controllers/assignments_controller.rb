class AssignmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def show
  end

  def new
    @customer = Customer.find params[:customer_id]
    @assignment = @customer.assignments.new
  end

  def edit
    @assignment = Assignment.find(params[:id])
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
      redirect_to @assignment.customer
      # redirect_to assignment_path(@assignment)
    else
      flash.now.alert = @assignment.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
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
      redirect_to customer_path
    end
  end
end
