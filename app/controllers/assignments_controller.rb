class AssignmentsController < ApplicationController
  
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
      
      @assignments = Assignment.all
    end
  
    def show 
      @assignment = Assignment.find(params[:id]) 
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
        redirect_to @customer
      else
        flash.now.alert = @assignment.errors.full_messages.to_sentence
        render :new  
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
      @assignment.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'Assignment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    def set_assignment 
      @assignment = Assignment.find(params[:id])
    end
    private
    def assignment_params
      params.require(:assignment).permit(:customer_id, :user_id, :status)
    end
end
